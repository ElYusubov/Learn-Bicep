// webapp-service-w-param.bicep

@description('Azure region to deploy all resources')
param location string

@minLength(2)
@description('App service name')
param appServiceAppName string

@minLength(2)
@description('App service plan name')
param appServicePlanName string

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
