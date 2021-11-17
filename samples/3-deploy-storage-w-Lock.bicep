// 3-deploy-storage-w-Lock.bicep

targetScope = 'subscription'

// parametrize inputs
param resourceGroupName string = 'storage-eastus2-demo'
param azureRegion string = 'eastus2' 

// add resource group
resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: azureRegion   // follow a good practice
  tags:{
    'Project': 'Omaha Azure User Group Demo'
    'Environment': 'Demo'   
  }
}

module storageModule '../modules/storage-param.bicep' = {
  scope: resourceGroup(myResourceGroup.name)
  name: 'storageDeployment-${uniqueString(myResourceGroup.id)}' // dynamic deployment name
  params: {
    geoRedundancy: false
  }
}
