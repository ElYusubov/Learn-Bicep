// azure-keyvault.bicep

@minLength(3)
@maxLength(24)
@description('Key vault name')
param keyVaultName string = 'mykeyvault114'

param azureRegion string = resourceGroup().location

// replace with your tenant-id
param keyObjectId string
// replace with your tenant-id
param tenantId string

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: keyVaultName
  location: azureRegion
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: tenantId
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: keyObjectId
        permissions: {
          keys: [
            'get'
          ]
          secrets: [
            'list'
            'get'
          ]
        }
      }
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}
