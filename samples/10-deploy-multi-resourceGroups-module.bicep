// 10-deploy-multi-resourceGroups-module.bicep

targetScope = 'subscription'

@description('Specifies the location for resources.')
param deploymentRegion string
param appResourceGroupName string // = 'rg-demo-app-${deploymentRegion}'
param storageResourceGroupName string // = 'rg-demo-storage-${deploymentRegion}'


resource storageResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: storageResourceGroupName
  location: deploymentRegion
  tags:{
    Project: 'Azure Demo Meetup'
    Environment: 'Demo'
  }
}

module storageModule '../modules/storage-param.bicep' = {
  scope: resourceGroup(storageResourceGroup.name)
  name: 'storageDeployment-${uniqueString(storageResourceGroup.id)}'
  params: {
    geoRedundancy: false
    azureRegion: deploymentRegion
  }
}

@description('App resource group declalartion')
resource appGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: appResourceGroupName
  location: deploymentRegion
}

@description('App service declaration from related module.')
module appService '../modules/appservice.bicep' = {
  scope: resourceGroup(appGroup.name)
  name: 'webAppDeployment-${uniqueString(appGroup.id)}' 
  params:{
    location: deploymentRegion
  }
}
