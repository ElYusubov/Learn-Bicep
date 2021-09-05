// 5-deploy-fail.bicep

targetScope = 'subscription'

// parametrize inputs
param resourceGroupName string = 'rg-BackToSchool-5'
param azureRegion string = 'westeurope' //'eastus2' 

// add resource group
resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: azureRegion   // is this a good practice
  tags:{
    'Project': 'Azure Back to School 2021'
    'Environment': 'Dev'   
  }
}

module storageModule '../modules/storage-param.bicep' = {
  scope: resourceGroup(myResourceGroup.name)
  name: 'storageDeployment-${uniqueString(myResourceGroup.id)}' // dynamic deployment name
  params: {
    geoRedundancy: false
  }
}
