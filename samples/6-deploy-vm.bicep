// 6-deploy-vm.bicep

targetScope = 'subscription'

// parametrize inputs
param resourceGroupName string = 'rg-BackToSchool-6'
param azureRegion string = 'eastus2' 
param appResourceGroupName string = 'rg-test-app'

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
    adminUserName: 'MyUser'
    adminPassword: 'MY%$3432passingday6'
    dnsLabelPrefix: 'backtoschool'
    location: azureRegion
  }
}
