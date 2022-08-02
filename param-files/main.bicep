param location string
param storageAccountName string

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  sku:{
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: null
  }
  
}

