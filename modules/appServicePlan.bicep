@description('The name of our App Service Plan')
param appServicePlanName string

@description('The location to deploy our App Service Plan')
param location string

@description('The SKU that we will provision this App Service Plan to.')
param appServicePlanSkuName string

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
    tier: 'Dynamic'
  }
  properties: {
  } 
}

output appServicePlanId string = appServicePlan.id
