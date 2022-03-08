// 5-deploy-fail.bicep

targetScope = 'subscription'

@description('Define the ResourceGroup Name')
param resourceGroupName string = 'rg-BackToSchool-5'

@description('Define the Azure Region')
param azureRegion string = 'westeurope' //'eastus2' 

@description('The Resource Group definition')
resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: azureRegion   // follow a good practice
  tags:{
    'Project': 'Azure Back to School 2021'
    'Environment': 'Dev'   
  }
}

@description('Define Azure storage account from the module.')
module storageModule '../modules/storage-param.bicep' = {
  scope: resourceGroup(myResourceGroup.name)
  name: 'storageDeployment-${uniqueString(myResourceGroup.id)}' // deployment name
  params: {
    geoRedundancy: false
  }
}
