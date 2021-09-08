param subscriptionId string = subscription().id
param name string = 'demo-bicep-webapp'
param location string = resourceGroup().location
param serverFarmResourceGroup string = resourceGroup().name
param sku string = 'Free'
param skuCode string = 'F1'

resource name_resource 'Microsoft.Web/sites@2018-11-01' = {
  name: name
  location: location
  properties: {
    siteConfig: {
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: 'dotnetcore'
        }
      ]
    }
    serverFarmId: '/subscriptions/${subscriptionId}/resourcegroups/${serverFarmResourceGroup}/providers/Microsoft.Web/serverfarms/${name}'
  }
  dependsOn: [
    Microsoft_Web_serverfarms_name
  ]
}

resource Microsoft_Web_serverfarms_name 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: name
  location: location
  properties: {
    name: name
  }
  sku: {
    tier: sku
    name: skuCode
  }
}
