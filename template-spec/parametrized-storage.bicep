@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
  'Premium_LRS'
])
param storageAccountType string = 'Standard_LRS'

param location string = resourceGroup().location

resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name:  'stg${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: storageAccountType
  }
  kind:'StorageV2'
}

// az group create -n 'kineteco-template-spec' -l 'eastus2'
// az ts create --name storageSpec --version "1.0.0" --resource-group 'kineteco-template-spec' --location "eastus2" --template-file .\template-spec\parametrized-storage.bicep

// az ts list
// az ts list -o table
// az ts show --name storageSpec  --resource-group 'kineteco-template-spec' --version "1.0.0"

// deploy template spec as Bash
// id=$(az ts show --name storageSpec --resource-group 'kineteco-template-spec' --version "1.0.0" --query "id")
// az deployment group create --resource-group 'kineteco-template-spec' --template-spec $id
