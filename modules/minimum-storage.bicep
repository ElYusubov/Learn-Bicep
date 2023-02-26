// minimum-storage.bicep with ASP

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

// insert Bicep Resource Id for App Service plan
@description('Generated from /subscriptions/xxxx')
resource aspbicepwebapps 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: 'asp-bicep-webapps-26'
  kind: 'app'
  location: region
  tags: {
    Project: 'Bicep-Part1'
    Environment: 'Test'
  }
  properties: {
    serverFarmId: 7442
    name: 'asp-bicep-webapps-26'
    workerSize: 'Default'
    workerSizeId: 0
    currentWorkerSize: 'Default'
    currentWorkerSizeId: 0
    currentNumberOfWorkers: 1
    webSpace: 'bicep-part1-webapp-eastus2-EastUS2webspace'
    planName: 'VirtualDedicatedPlan'
    computeMode: 'Dedicated'
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    tags: {
      Project: 'Bicep-Part1'
      Environment: 'Test'
    }
    kind: 'app'
    reserved: false
    isXenon: false
    hyperV: false
    mdmId: 'waws-prod-bn1-185_7442'
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
}
