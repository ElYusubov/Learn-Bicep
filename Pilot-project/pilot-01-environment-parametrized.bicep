// pilot-webapp-environment

@description('Unique string for resource naming')
param appNamePrefix string = uniqueString(resourceGroup().id)

@description('Name of the app service plan')
param appServicePlanName string = '${appNamePrefix}-appplan'

@description('Name of the web app')
param webAppName string = '${appNamePrefix}-kinetecowebapp'

@description('Location for all resources.')
param azureRegion string = 'eastus2'

@description('Name of the storage account')
param appStorageName string = format('{0}stg1', replace(appNamePrefix, '-', ''))

@description('Name of the app insights')
var appInsightsName = '${appNamePrefix}-appinsights'

@description('Tags for all resources.')
var appTags = {
  AppName: 'myKinetEcoTracking'
  Environment: 'Test'
}

// Create App Service Plan resources
resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: azureRegion
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  tags: appTags
}

// Create App Service resources
resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: webAppName
  location: azureRegion
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
  tags: appTags
}

// Create Storage Account resource
resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: appStorageName
  location: azureRegion
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: appTags
}

// Create App Insights resource
resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: azureRegion
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
  tags: appTags
}

@description('Provides a deployed apps host name.')
output webAppHostName string = appServiceApp.properties.defaultHostName
