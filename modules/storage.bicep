// storage.bicep

// let's use snippets

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'stgbacktoschool942021'
  location: resourceGroup().location
  kind: 'StorageV2' 
  sku: {
    name: 'Standard_LRS'
  }
}

