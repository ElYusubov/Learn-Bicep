// acr-registry.bicep

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2019-05-01' = {
  name: 'demoacr912'
  location: resourceGroup().location
  sku: {
    name: 'Standard'
  }
  properties: {
    adminUserEnabled: true
  }
}

output acrLoginServer string = containerRegistry.properties.loginServer
