// you can use powershell or CLI to create 
// az group create -n 'kineteco-private-registry-test-eastus2' -l 'eastus2'
// az acr create --name "kinetecodevregistry" --sku Basic -g 'kineteco-private-registry-test-eastus2'

// az bicep publish --file acr.bicep --target br:bicepPart1PrivateRegistry.azurecr.io/bicep/modules/acr:v1

// minor change and publish as v2
// az acr show -n bicepPart1PrivateRegistry -o table
// az acr repository list -n bicepPart1PrivateRegistry

// To fetch Private registry modules before build
// bicep restore --file module.bicep

param acrName string = 'bicepPart1PrivateRegistry'

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: acrName
  #disable-next-line no-loc-expr-outside-params
  location: resourceGroup().location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}
