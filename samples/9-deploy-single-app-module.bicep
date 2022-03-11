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

@description('App Host full name.')
output myNewBicepAppHostName string = appService.outputs.webAppHostName
