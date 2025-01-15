// Deploy an Azure Container Registry via AVM Modules
// https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/container-registry/registry

module registry 'br/public:avm/res/container-registry/registry:0.7.0' = {
  name: 'registryDeployment'
  params: {
    // Required parameters
    name: 'privacrdemo001'
    // Non-required parameters
    acrSku: 'Standard'
    location: 'eastus2'
  }
}
