// minimum-storage.bicep
param region string = resourceGroup().location
param notHelpful string = 'new'

resource storageaccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'nextstgba2sc25'
  location: region
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    Environment: 'Demo'
    Project: 'Azure December Joy 2022'
  }
}

resource stgaccount2 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'azfestive1216'
  location: region
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource stgFestiveDrive 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'azfestivecalendar2022'
  location: region
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

