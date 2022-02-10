// 14-deploy-child-parent-scenarios.bicep

// TODO: add description and variable names
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

// Option 1: child resource created with reference to parent
resource myStorageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  name: 'data-log'
  parent: myStorageBlobServices
}

// Option 2: child resource included into declaration
resource myStorageBlobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  name: 'default'
  parent: storageAccount

  resource internalContainer 'containers@2021-06-01' = {
    name: 'internalContainer'
  }
  
}

// Option 3: Automation utomation with enumaration :) 
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = [ for containerName in containerNames: {
  name: '${storageAccount.name}/default/${containerName}'
}]
