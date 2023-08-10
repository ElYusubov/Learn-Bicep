// 14-deploy-child-parent-scenarios.bicep

@description('The name of the storage account.')
param storageAccountName string = 'ey22${uniqueString(resourceGroup().id)}'

@description('Azure deployment region.')
param deploymentRegion string = resourceGroup().location

@description('The list of container names.')
var containerNames = ['logs', 'inputs', 'outputs']

@description('A parent storage account resource.')
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: deploymentRegion
  kind: 'StorageV2'
  sku: {
    name: 'Standard_GRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

@description('Option 1: child resource created with reference to parent.')
resource myStorageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  name: 'data-log'
  parent: myStorageBlobServices
}

@description('Option 2: including a child resource in the declaration.')
resource myStorageBlobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  name: 'default'
  parent: storageAccount

  resource internalContainer 'containers@2021-06-01' = {
    name: 'internalcontainer'
  }
}

@description('Option 3: Automation and looping with enumeration :) ')
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = [
  for containerName in containerNames: {
    name: '${storageAccount.name}/default/${containerName}'
  }
]
