// storage.bicep

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


resource testStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'teststgschool0956'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

