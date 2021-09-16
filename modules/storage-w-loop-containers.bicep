// storage-w-loop-containers.bicep

param storageAccountName string = 'stor${uniqueString(resourceGroup().id)}'

var containerNames = [
 'logs'
 'inputs'
 'outputs'
]

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

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = [ for containerName in containerNames: {
  name: '${storageAccount.name}/default/${containerName}'
}]
