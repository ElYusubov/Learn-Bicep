// 7-deploy-modules-w-param.bicep

targetScope = 'subscription'

// parametrize inputs
param azureRegion string = 'eastus2' 
param resourceGroupName string = 'rg-cll-vm-${azureRegion}'
param appResourceGroupName string = 'rg-cll-app-${azureRegion}'
param userName string = 'MyUser'
@secure()
param secretPass string

// add APP service resource group
resource myAppResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: appResourceGroupName
  location: azureRegion
  tags:{
    'Project': 'Azure CLL session 2021'
    'Environment': 'Demo'
  }
}

module appService '../modules/appservice.bicep' = {
  scope: resourceGroup(myAppResourceGroup.name)
  name: 'webAppDeployment-${uniqueString(myAppResourceGroup.id)}'
}


// add VM resource group
resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: azureRegion
  tags:{
    'Project': 'Azure Back to School 2021'
    'Environment': 'Demo'
  }
}

module winVMModule '../modules/vm-win.bicep' = {
  scope: resourceGroup(myResourceGroup.name)
  name: 'winVMDeployment-${uniqueString(myResourceGroup.id)}' // dynamic deployment name
  params: {
    adminUserName: userName
    adminPassword: secretPass
    dnsLabelPrefix: 'cllsession'
    location: azureRegion
  }
}
