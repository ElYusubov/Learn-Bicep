// 7-deploy-modules-w-param.bicep
// Sample AZ CLI deployment script
// az deployment sub create --location eastus -f .\samples\7-deploy-modules-w-param.bicep -p .\param-files\7-deploy-modules-w-param.dev.json -c

targetScope = 'subscription'

@description('Azure region location.')
param azureRegion string = 'eastus'

param resourceGroupName string // = 'rg-demo-vm-${azureRegion}'
param appResourceGroupName string // = 'rg-demo-app-${azureRegion}'
param storageResourceGroupName string // = 'rg-demo-storage-${azureRegion}'
param userName string

@secure()
param secretPass string

// add an APP service resource group
resource myAppResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: appResourceGroupName
  location: azureRegion
  tags:{
    'Project': 'Festive Tech Calendar 2021'
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
    'Project': 'Festive Tech Calendar 2021'
    'Environment': 'Demo'
  }
}

module winVMModule '../modules/vm-win.bicep' = {
  scope: resourceGroup(myResourceGroup.name)
  name: 'winVMDeployment-${uniqueString(myResourceGroup.id)}' // dynamic deployment name
  params: {
    adminUserName: userName
    adminPassword: secretPass
    dnsLabelPrefix: 'demosession'
    location: azureRegion
  }
}

// add resource group for a Storage
resource storageResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: storageResourceGroupName
  location: azureRegion
  tags:{
    'Project': 'Festive Tech Calendar 2021'
    'Environment': 'Demo'
  }
}

module storageModule '../modules/storage-param.bicep' = {
  scope: resourceGroup(storageResourceGroup.name)
  name: 'storageDeployment-${uniqueString(storageResourceGroup.id)}'
  params: {
    geoRedundancy: false
  }
}

module cosmosDBModule '../modules/cosmosdb.bicep' = {
  scope: resourceGroup(storageResourceGroup.name)
  name: 'cosmosDBDeployment-${uniqueString(storageResourceGroup.id)}'
}
