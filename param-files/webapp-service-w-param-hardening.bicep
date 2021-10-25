// webapp-service-w-param-harening.bicep

@description('Azure region to deploy all resources')
@allowed([
  'eastus'
  'eastus2'
  'westus'
  'westus2'
])
param location string

@minLength(2)
@maxLength(60)
@description('App service name')
param appServiceAppName string

@minLength(1)
@maxLength(40)
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
