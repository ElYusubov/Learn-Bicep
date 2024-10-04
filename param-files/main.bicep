// main.bicep - simple storage account creation sample

@description('The azure region location.')
param azureRegion string

@description('The name of the storage account.')
param storageAccountName string

// Create a storage account
resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: azureRegion
  sku:{
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: null
  }
}
