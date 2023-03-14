@maxLength(6)
param prefix string = 'azs23'

param storageName string = 'stg${prefix}'
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

resource secondStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'secstg01${prefix}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
