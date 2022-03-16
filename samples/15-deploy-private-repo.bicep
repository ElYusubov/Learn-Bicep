// 15-deploy-private-repo.bicep

// Step-1: Create Azure container registry (ACR)
// Use the modules/acr-registry.bicep

// Step-2: Get the login server name of the ACR
// az acr login --name mybicepacr37

// Step-3: Publish a Bicep file as a module to a private module registry

// Step-4: Call the private module in your Bicep code

// module regAppService 'br:azwelshug0315.azurecr.io/bicep/modules/appservice:v1' = {
//   name: 'appServiceDeploy'
//   params: {
//     location: 'eastus'
//     appServiceAppName: 'azwelshug0315'
//   }
// }

module regAppService2 'br/CoreModules:appservice:v2' = {
  name: 'appServiceDeploy2'
  params: {
    location: 'eastus'
    appServiceAppName: 'newapp031555'
  }
}
