// acr-registry.bicep

@minLength(5)
@maxLength(50)
@description('Provide a unique name between 5-50 char. for the Azure Container Registry')
param acrName string = 'acr${uniqueString(resourceGroup().id)}'

@description('Provide a Azure deployment region/location for the registry.')
param deploymentRegion string = resourceGroup().location

@description('Provide a tier of your Azure Container Registry.')
param acrSku string = 'Basic'

resource acrResource 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: acrName
  location: deploymentRegion
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: false
  }
}

@description('Output the login server property for later use')
output loginServer string = acrResource.properties.loginServer

// Sample on Insert Resource
// @description('Generated from exisiting storage account')
// resource bsuniquesmb 'Microsoft.Storage/storageAccounts@2022-09-01' = {
//   sku: {
//     name: 'Standard_GRS'
//   }
//   kind: 'StorageV2'
//   name: 'bs27uniquesmb928'
//   location: 'eastus'
//   tags: {
//   }
//   properties: {
//     minimumTlsVersion: 'TLS1_0'
//     allowBlobPublicAccess: true
//     networkAcls: {
//       bypass: 'AzureServices'
//       virtualNetworkRules: []
//       ipRules: []
//       defaultAction: 'Allow'
//     }
//     supportsHttpsTrafficOnly: true
//     encryption: {
//       services: {
//         file: {
//           keyType: 'Account'
//           enabled: true
//         }
//         blob: {
//           keyType: 'Account'
//           enabled: true
//         }
//       }
//       keySource: 'Microsoft.Storage'
//     }
//     accessTier: 'Hot'
//   }
// }
