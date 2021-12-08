// minimum-storage.bicep

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'uniquestgdm1117'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    'Environment': 'Demo'
    'Project': 'Festive Tech Calendar 2021'
  }
}
