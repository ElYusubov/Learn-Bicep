// storage.bicep

@description('The prefix that will appear infront of storage account name.')
@maxLength(6)
param prefix string = 'demo24'

@description('The Azure region where the storage account will be created.')
param location string = resourceGroup().location

@description('The storage name prefix.')
param storageName string = 'stg${prefix}'

@description('The environment to deploy the storage account to. Valid values are "dev" or "prod".')
param environment string = 'dev'
var storageAccountSkuName = (environment == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

@description('The name of the storage account')
var accountName = '${storageName}${environment}'

// Creates a storage account
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

// Creates a second storage account
resource secondStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'secstg01${prefix}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
