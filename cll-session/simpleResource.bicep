resource bareStorage 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'storagecll1119'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
