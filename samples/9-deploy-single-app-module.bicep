// 9-deploy-single-app-module.bicep

module appService '../modules/appservice.bicep' = {
  name: 'myNewBicepApp'
  params:{
    appServiceAppName: 'myBicepApp007'
    appServicePlanName: 'asp-BicepApp'
    location: resourceGroup().location
  }
}

output myNewBicepAppHostName string = appService.outputs.webAppHostName
