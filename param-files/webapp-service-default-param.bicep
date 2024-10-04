// webapp-service-default-param.bicep

@description('The azure region location inherited from the RG.')
param azureRegion string = resourceGroup().location

@description('The name of the web app.')
param appServiceAppName string = 'parademo${uniqueString(resourceGroup().id)}'

@description('The name of the app service plan.')
param appServicePlanName string = 'paramdemo-plan'

// Create an app service plan
resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: azureRegion
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}

// Create a web app
resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceAppName
  location: azureRegion
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

@description('The web app host name host name.')
output webAppHostName string = appServiceApp.properties.defaultHostName
