// you can use powershell or CLI to create 
// az group create -n 'latam-private-registry-test-eastus2' -l 'eastus2'
// az acr create --name "latamprivateregistry" --sku Basic -g 'latam-private-registry-test-eastus2'

// Deploying the acr code
// az deployment group create -g 'latam-private-registry-test-eastus2' -f .\private-project\acr.bicep -c 

// Publish the appservice-demo.bicep
// az bicep publish --file appservice-demo.bicep --target br:latamprivateregistry5.azurecr.io/bicep/modules/acr:v1.0.0

// minor change and publish as v2
// az acr show -n bicepPart1PrivateRegistry -o table
// az acr repository list -n bicepPart1PrivateRegistry

// To fetch Private registry modules before build
// bicep restore --file module.bicep

param acrName string = 'latamprivateregistry'

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
