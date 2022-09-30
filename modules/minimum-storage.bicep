// minimum-storage.bicep
param region string = resourceGroup().location

resource storageaccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'nextstgba2sc25'
  location: region
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    Environment: 'Demo'
    Project: 'Azure Dominicana 2022'
  }
}

resource stgaccount2 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'azdominey0929'
  location: region
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
