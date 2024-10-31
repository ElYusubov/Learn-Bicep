// pilot-01-environment.bicep

@description('Azure location for all resources')
param azureRegion string = resourceGroup().location

// Create App Service Plan resources
resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: 'kinetEco35-appplan'
  location: azureRegion
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  tags: {
    AppName: 'myKinetEcoTracking'
    Environment: 'Test'
  }
}

// Create App Service resources
resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: 'kinetEco35-webapp'
  location: azureRegion
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
  tags: {
    AppName: 'myKinetEcoTracking'
    Environment: 'Test'
  }
}

// Create Storage Account resource
resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'kinetecotracking35stg1'
  location: azureRegion
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    AppName: 'myKinetEcoTracking'
    Environment: 'Test'
  }
}

// Create App Insights resource
resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: 'kinetEco35-appinsights'
  location: azureRegion
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
  tags: {
    AppName: 'myKinetEcoTracking'
    Environment: 'Test'
  }
}

@description('Provides a deployed apps host name.')
output webAppHostName string = appServiceApp.properties.defaultHostName
