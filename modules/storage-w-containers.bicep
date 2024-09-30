// storage-w-containers.bicep

@description('Parameter for a storage account name')
param storageAccountName string = 'stor${uniqueString(resourceGroup().id)}'

@description('The name of the container that will be created in the storage account')
param containerName string = 'logs'
// param inputContainerName string = 'inputs'
// param outputContainerName string = 'outputs'

@description('The Azure region where the storage account will be created.')
param azureRegion string = resourceGroup().location

// Createa a storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: azureRegion
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
