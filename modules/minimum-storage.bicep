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

// example of insert resourse

@description('Generated from /subscriptions/xxxx/resourceGroups/BicepTest-RG/providers/Microsoft.Web/serverFarms/play-website')
resource playwebsite 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'play-website'
  kind: 'app'
  location: 'East US 2'
  properties: {
    serverFarmId: 7787
    name: 'play-website'
    workerSize: 'Default'
    workerSizeId: 0
    currentWorkerSize: 'Default'
    currentWorkerSizeId: 0
    currentNumberOfWorkers: 0
    webSpace: 'BicepTest-RG-EastUS2webspace'
    planName: 'VirtualDedicatedPlan'
    computeMode: 'Shared'
    siteMode: 'Limited'
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 0
    isSpot: false
    kind: 'app'
    reserved: false
    isXenon: false
    hyperV: false
    mdmId: 'waws-prod-bn1-215_7787'
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
    vnetConnectionsUsed: 0
    vnetConnectionsMax: 2
    createdTime: '2023-09-29T14:07:51.99'
  }
  sku: {
    name: 'F1'
    tier: 'Free'
    size: 'F1'
    family: 'F'
    capacity: 0
  }
}
