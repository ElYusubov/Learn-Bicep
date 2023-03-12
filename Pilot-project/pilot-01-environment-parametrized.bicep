// pilot-webapp-environment

param appNamePrefix string = uniqueString(resourceGroup().id)

param appServicePlanName string = '${appNamePrefix}-appplan'
param webAppName string = '${appNamePrefix}-kinetecowebapp'
param location string = 'eastus2'

param appStorageName string = format('{0}stg1', replace(appNamePrefix, '-', ''))
var appInsightsName = '${appNamePrefix}-appinsights'

var appTags = {
  AppName: 'myKinetEcoTracking'
  Environment: 'Test'
}

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  tags: appTags
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
  tags: appTags
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: appStorageName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: appTags
}

resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
  tags: appTags
}
