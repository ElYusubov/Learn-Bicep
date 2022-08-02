// 17-deploy-event-streaming-app.bicep
// ref: https://www.willvelida.com/posts/building-streaming-app-event-hubs-functions-cosmos/

@description('The location where we will deploy our resources to. Default is the location of the resource group')
param location string = resourceGroup().location

@description('Name of our application.')
param applicationName string = uniqueString(resourceGroup().id)

@description('The SKU for the storage account')
param storageSku string = 'Standard_LRS'

var appServicePlanName = '${applicationName}asp'
var appServicePlanSkuName = 'Y1'
var storageAccountName = 'fnstor${replace(applicationName, '-', '')}'
var functionAppName = '${applicationName}func'
var functionRuntime = 'dotnet'
var cosmosDbAccountName = '${applicationName}db'
var databaseName = 'ReadingsDb'
var containerName = 'Readings'
var containerThroughput = 400
var appInsightsName = '${applicationName}ai'
var eventHubsName = '${applicationName}eh'
var eventHubsSkuName = 'Basic'
var hubName = 'readings'

module cosmosDb '../modules/cosmosDb.bicep' = {
  name: 'cosmosDb'
  params: {
    containerName: containerName 
    containerThroughput: containerThroughput
    cosmosDbAccountName: cosmosDbAccountName
    databaseName: databaseName
    location: location
  }
}

module appServicePlan '../modules/appServicePlan.bicep' = {
  name: 'appServicePlan'
  params: {
    appServicePlanName: appServicePlanName 
    appServicePlanSkuName: appServicePlanSkuName
    location: location
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageSku
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

module eventHub '../modules/eventHubs.bicep' = {
  name: 'eventHub'
  params: {
    eventHubsName: eventHubsName 
    eventHubsSkuName: eventHubsSkuName
    hubName: hubName
    location: location
  }
}

resource functionApp 'Microsoft.Web/sites@2021-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: appServicePlan.outputs.appServicePlanId
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value}'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: 'InstrumentationKey=${appInsights.properties.InstrumentationKey}'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: functionRuntime
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'DatabaseName'
          value: cosmosDb.outputs.databaseName
        }
        {
          name: 'ContainerName'
          value: cosmosDb.outputs.containerName
        }
        {
          name: 'CosmosDbEndpoint'
          value: cosmosDb.outputs.cosmosDbEndpoint
        }
        {
          name: 'EventHubConnection__fullyQualifiedNamespace'
          value: '${eventHub.outputs.eventHubNamespaceName}.servicebus.windows.net'
        }
        {
          name: 'ReadingsEventHub'
          value: eventHub.outputs.eventHubName
        }
      ]
    }
    httpsOnly: true
  } 
  identity: {
    type: 'SystemAssigned'
  }
}

module eventHubRoles '../modules/eventHubRoleAssignment.bicep'  = {
  name: 'eventhubsroles'
  params: {
    eventHubNamespaceName: eventHub.outputs.eventHubNamespaceName 
    functionAppId: functionApp.id
    functionAppPrincipalId: functionApp.identity.principalId
  }
}

module sqlRoleAssignment '../modules/sqlRoleAssignment.bicep' = {
  name: 'sqlRoleAssignment'
  params: {
    cosmosDbAccountName: cosmosDb.outputs.cosmosDbAccountName
    functionAppPrincipalId: functionApp.identity.principalId
  }
}
