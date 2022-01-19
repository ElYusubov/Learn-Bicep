// storage-w-loop-containers.bicep
// Provion a storage account with naming convention
// Add a child resource to parent resource
// Add conatiners to the parent blob service from list of values

param storageAccountName string = 'clls${uniqueString(resourceGroup().id)}'

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

resource myStorageBlobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  name: 'default'
  parent: storageAccount
}

resource myStorageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  name: 'data-log'
  parent: myStorageBlobServices
}

// try automation with enumaration :) 
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = [ for containerName in containerNames: {
  name: '${storageAccount.name}/default/${containerName}'
}]
