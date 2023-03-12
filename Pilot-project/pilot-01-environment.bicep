// pilot-webapp-environment
param location string = 'eastus2'

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: 'kinetEco35-appplan'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  tags: {
    AppName: 'myKinetEcoTracking'
    Environment: 'Test'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: 'kinetEco35-webapp'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
  tags: {
    AppName: 'myKinetEcoTracking'
    Environment: 'Test'
  }
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'kinetecotracking35stg1'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    AppName: 'myKinetEcoTracking'
    Environment: 'Test'
  }
}

resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: 'kinetEco35-appinsights'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
  tags: {
    AppName: 'myKinetEcoTracking'
    Environment: 'Test'
  }
}
