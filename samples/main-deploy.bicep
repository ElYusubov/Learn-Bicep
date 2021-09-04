// main.bicep

targetScope = 'subscription'

// parametrize inputs
param resourceGroupName string = 'rg-BackToSchool'
param azureRegion string = 'eastus2' 

// add resource group
resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: azureRegion   // is this a good practice
  tags:{
    'Project': 'Azure Back to School 2021'
    'Environment': 'Dev'   
  }
}

