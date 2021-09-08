// storage.bicep

// use snippets

param storageName string = 'stgbacktoschool942021'
param location string = resourceGroup().location

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: location
  kind: 'StorageV2' 
  sku: {
    name: 'Standard_LRS'
  }
  tags:{
    'ms-resource-usage': 'azure-cloud-shell'
  }
}

resource nextStorage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'cllsession9656'
  location: 'westus'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    'project': 'cll demo'
  }
}

