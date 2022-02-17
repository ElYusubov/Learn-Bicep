// main.bicep - test pipline
// Requires registration of Microsoft.Web, Insights & AlertsManagment

@description('The Azure region (location) for deployment.')
param location string = resourceGroup().location

@description('The allowed environment types are: Dev, Test, and Prod.')
@allowed([
  'Dev'
  'Test'
  'Prod'
])
param environmentType string

@description('A unique suffix for resource names that requires a global uniqueness.')
@minLength(3)
@maxLength(13)
param resourceNameSuffix string = uniqueString(resourceGroup().id)

var appServiceAppName = 'playwebsite-${resourceNameSuffix}'
var appServicePlanName = 'play-website'
var applicationInsightsName = 'playwebsite'

@description('Storage account name.')
var storageAccountName = 'pystg${resourceNameSuffix}'

@description('Configurations based on SKUs and the environment type.')
var environmentConfigurationMap = {
  Dev: {
    appServicePlan: {
      sku: {
        name: 'F1'
      }
    }
  }
  Prod: {
    appServicePlan: {
      sku: {
        name: 'S1'
        capacity: 1
      }
    }
  }
  Test: {
    appServicePlan: {
      sku: {
        name: 'F1'
      }
    }
  }
}

@description('Application Service Plan for the web app.')
resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: appServicePlanName
  location: location
  sku: environmentConfigurationMap[environmentType].appServicePlan.sku
}

@description('Web App with instrumentation key.')
resource appServiceApp 'Microsoft.Web/sites@2021-01-15' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: applicationInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: applicationInsights.properties.ConnectionString
        }
      ]
    }
  }
}

@description('App Insights')
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
    Flow_Type: 'Bluefield'
  }
}

@description('Storage account of the deployment.')
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

output appServiceAppHostName string = appServiceApp.properties.defaultHostName
