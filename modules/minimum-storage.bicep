// minimum-storage.bicep
// param region string 

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'nextstgba2sc25'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    Environment: 'Demo'
    Project: 'Azure Back to School 2022'
  }
}
