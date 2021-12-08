// appservice.bicep

param location string = resourceGroup().location
param appServiceAppName string = 'bicepapp${uniqueString(resourceGroup().id)}'
param appServicePlanName string = 'bicepapp-plan'

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

output webAppHostName string = appServiceApp.properties.defaultHostName
