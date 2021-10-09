// storage-w-containers.bicep

param storageAccountName string = 'stor${uniqueString(resourceGroup().id)}'
param containerName string = 'logs'
// param inputContainerName string = 'inputs'
// param outputContainerName string = 'outputs'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_GRS'
  }
  properties:{
    accessTier: 'Hot'
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = {
  name: '${storageAccount.name}/default/${containerName}'
}
