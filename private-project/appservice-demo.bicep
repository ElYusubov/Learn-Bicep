// appservice-demo.bicep

@description('Provide a Azure deployment region/location for the registry.')
param location string = resourceGroup().location

@description('App service name.')
param appServiceAppName string = 'myapp${uniqueString(resourceGroup().id)}'

@description('App service plan name.')
param appServicePlanName string = 'asp-plan${uniqueString(resourceGroup().id)}'

// Create an App Service Plan
resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}

// Create an App Service
resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

// resource Id of Application insights
// /subscriptions/xxx
@description('Provides a deployed apps host name.')
output webAppHostName string = appServiceApp.properties.defaultHostName
