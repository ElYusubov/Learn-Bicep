// 6-deploy-vm.bicep

targetScope = 'subscription'

@description('An Azure Resource Group name')
param resourceGroupName string

@description('Azure region')
param azureRegion string 

@description('Application resource Group name')
param appResourceGroupName string

@description('User Name')
param userName string

@description('Secure secret/pass')
@secure()
param secretPass string

@description('App Resource Group definition')
resource myAppResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: appResourceGroupName
  location: azureRegion
  tags:{
    Project: 'Azure Back to School Demo02'
    Environment: 'Demo'
  }
}

@description('App Services from module')
module appService '../modules/appservice.bicep' = {
  scope: resourceGroup(myAppResourceGroup.name)
  name: 'webAppDeployment-${uniqueString(myAppResourceGroup.id)}'
}


@description('Resource Group for VM workloads')
resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: azureRegion
  tags:{
    Project: 'Azure Back to School Demo02'
    Environment: 'Demo'
  }
}

@description('Win VM definition from module')
module winVMModule '../modules/vm-win.bicep' = {
  scope: resourceGroup(myResourceGroup.name)
  name: 'winVMDeployment-${uniqueString(myResourceGroup.id)}' // dynamic deployment name
  params: {
    adminUserName: userName
    adminPassword: secretPass
    dnsLabelPrefix: 'backtoschool'
    location: azureRegion
  }
}
