
targetScope = 'subscription'

@description('Specifies the location for resources.')
param deploymentRegion string = 'eastus'

@description('App resource group declalartion')
resource appGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'bicep-containers-rg'
  location: deploymentRegion
}

@description('App service declaration from related module.')
module appService '../modules/appservice.bicep' = {
  scope: resourceGroup(appGroup.name)
  name: 'webAppDeployment-${uniqueString(appGroup.id)}' 
  params:{
    location: deploymentRegion
  }
}
