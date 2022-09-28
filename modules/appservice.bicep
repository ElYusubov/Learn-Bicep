// appservice.bicep

@description('Provide a Azure deployment region/location for the registry.')
param location string = resourceGroup().location

@description('App service name.')
param appServiceAppName string = 'myapp${uniqueString(resourceGroup().id)}'

@description('App service plan name.')
param appServicePlanName string = 'myapp-plan'

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

// /subscriptions/e1dbf1c1-1854-475e-a1f6-bfb5d2a66337/resourceGroups/autoflash-compute-eastus-test/providers/microsoft.insights/components/docker-test-suit

@description('Provides a deployed apps host name.')
output webAppHostName string = appServiceApp.properties.defaultHostName
