// storage-w-loop-containers.bicep
// Provion a storage account with naming convention
// Add a child resource to parent resource
// Add conatiners to the parent blob service from list of values

@description('The prefix that will appear infront of storage account name.')
param storageAccountName string = 'ftc${uniqueString(resourceGroup().id)}'

@description('The Azure region where the storage account will be created.')
param azureregion string = resourceGroup().location

@description('The list of containers that will be created in the storage account')
var containerNames = [
 'logs'
 'inputs'
 'outputs'
]

// Creates a storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: azureregion
  kind: 'StorageV2'
  sku: {
    name: 'Standard_GRS'
  }
  properties:{
    accessTier: 'Hot'
  }
}

// Create a blob service
resource myStorageBlobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  name: 'default'
  parent: storageAccount
}

// Creates a container
resource myStorageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  name: 'data-log'
  parent: myStorageBlobServices
}

// Creates containers by using enumaration 
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = [ for containerName in containerNames: {
  name: '${storageAccount.name}/default/${containerName}'
}]

// Lock the storage account to prevent accidential deletion
resource lockResourceGroup 'Microsoft.Authorization/locks@2016-09-01' = {
  name: 'DontDelete'
  scope: storageAccount
  properties: {
    level: 'CanNotDelete'
  }
}
