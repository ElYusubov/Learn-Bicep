// 9-deploy-single-app-module.bicep

@description('Deployment location of Azure services.')
param deploymentLocation string = resourceGroup().location

module appService '../modules/appservice.bicep' = {
  name: 'myNewBicepApp'
  params:{
    appServiceAppName: 'myBicepApp007'
    appServicePlanName: 'asp-BicepApp'
    location:deploymentLocation
  }
}

resource storageTest2 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'cllstg011123'
  location: deploymentLocation
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

@description('App Host full name.')
output myNewBicepAppHostName string = appService.outputs.webAppHostName
