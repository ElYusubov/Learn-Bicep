// storage.bicep

param storageName string = 'stgbacktoschool942021'
param location string = resourceGroup().location
param environment string = 'dev'
var storageAccountSkuName = (environment == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var accountName = '${storageName}${environment}'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: accountName
  location: location
  kind: 'StorageV2' 
  sku: {
    name: storageAccountSkuName
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

