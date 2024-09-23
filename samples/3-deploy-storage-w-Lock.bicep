// 3-deploy-storage-w-Lock.bicep

// Deployment scope: subscription
targetScope = 'subscription'

@description('Resource group name.')
param resourceGroupName string = 'cll-storage-eastus2-demo'

@description('Azure region selection.')
param azureRegion string = 'eastus2' 

@description('Resource group defintion')
resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: azureRegion
  tags:{
    Project: 'Session Demo'
    Environment: 'Demo'   
  }
}

@description('Storage module with a parameter defined.')
module storageModule '../modules/storage-param.bicep' = {
  scope: resourceGroup(myResourceGroup.name)
  name: 'storageDeployment-${uniqueString(myResourceGroup.id)}' // dynamic deployment name
  params: {
    geoRedundancy: false
    azureRegion: azureRegion
  }
}
