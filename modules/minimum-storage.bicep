// minimum-storage.bicep with ASP

@description('The location that these Storage Account resources will be deployed to')
param azureRegion string = resourceGroup().location

param notHelpful string = 'new'   // Fails due to Linter rule

// Storage Account
resource storageaccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'nextstgba2sc25'
  location: azureRegion
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    Environment: 'Demo'
    Project: 'Test Bicep 2025'
  }
}
