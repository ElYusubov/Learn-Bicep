resource cllstorage 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'cllstorage118'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS' 
  }
  kind: 'StorageV2'
}

