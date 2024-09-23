// 2-deploy-param-storage.bicep

// Deployment scope: subscription
targetScope = 'subscription'

@description('Resource Group name for the deployment')
@minLength(3)
@maxLength(90)
param resourceGroupName string = 'rg-BicepDemo'

@description('Azure region to deploy all resources')
@allowed([
  'eastus'
  'eastus2'
  'westus'
  'westus2'
])
param azureRegion string = 'eastus2'

@description('Resource group declaration for the storage account.')
resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: azureRegion
  tags:{
    Project: 'Azure Back to School 2024'
    Environment: 'Dev'
  }
}

@description('Storage declaration from exisiting module with a preset parameter')
module storageModule '../modules/storage-param.bicep' = {
  scope: resourceGroup(myResourceGroup.name)
  name: 'storageDeployment-${uniqueString(myResourceGroup.id)}' // dynamic deployment name
  params: {
    geoRedundancy: false
    azureRegion: azureRegion
  }
}
