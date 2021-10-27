// webapp-service-w-param-hardening.bicep

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

@allowed([
  'dev'
  'test'
  'prod'
])
param environmentName string

var environmentSettings = {
  dev: {
    instanceName: 'F1'
    instanceTier: 'Free'
  }
  test: {
    instanceName: 'D1'
    instanceTier: 'Shared'
  }
  prod: {
    instanceName: 'B3'
    instanceTier: 'Basic'
  }
}

var instanceName = environmentSettings[environmentName].instanceName
var instanceTier = environmentSettings[environmentName].instanceTier

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: instanceName
    tier: instanceTier
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
