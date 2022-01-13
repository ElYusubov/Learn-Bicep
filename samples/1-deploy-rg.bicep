// 1-deploy-rg.bicep

targetScope = 'subscription'

@description('The name of the Resource Group.')
param resourceGroupName string = 'rg-BackToSchool'

@description('The Azure region into which the resources should be deployed.')
param azureRegion string = 'eastus2'

// Warning for the build as bicepconfig warns any un-used param declaration
param deleteUnusedParam string
var deleteUnusedVar

resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: azureRegion   // is this a good practice
  tags:{
    'Project': 'Azure Back to School 2021'
    'Environment': 'Dev'   
  }
}
