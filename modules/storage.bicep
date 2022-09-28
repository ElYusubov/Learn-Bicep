// storage.bicep

param prefix string = 'baey2s927'
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

resource testStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'tstel${prefix}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
