// minimum-storage.bicep with ASP

param region string = resourceGroup().location
param notHelpful string = 'new'   // Fails due to Linter rule

resource storageaccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'nextstgba2sc25'
  location: region
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    Environment: 'Demo'
    Project: 'MVP TechBytes 2023'
  }
}
