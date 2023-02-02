// 1-deploy-rg.bicep

targetScope = 'subscription'

@description('The name of the Resource Group.')
param resourceGroupName string = 'rg-BackToFuture'

@description('The Azure region into which the resources should be deployed.')
param azureRegion string = 'eastus2'

// Warning for the build as bicepconfig warns on a unused param & unused variable declarations below
param deleteUnusedParam string
var deleteMe = 'default'

@description('Created a resource group')
resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: azureRegion
  tags:{
    Project: 'Azure Back to School 2022'
    Environment: 'Demo'   
  }
}
