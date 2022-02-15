// 14-deploy-child-parent-scenarios.bicep

@description('The name of the storae account.')
param storageAccountName string = 'azli${uniqueString(resourceGroup().id)}'

@description('The list of container names.')
var containerNames = [
 'logs'
 'inputs'
 'outputs'
]

@description('A parent storage account resource.')
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

@description('Option 1: child resource created with reference to parent.')
resource myStorageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  name: 'data-log'
  parent: myStorageBlobServices
}

@description('Option 2: child resource included into declaration')
resource myStorageBlobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  name: 'default'
  parent: storageAccount

  resource internalContainer 'containers@2021-06-01' = {
    name: 'internalContainer'
  }
}

@description('Option 3: Automation utomation with enumaration :) ')
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = [ for containerName in containerNames: {
  name: '${storageAccount.name}/default/${containerName}'
}]
