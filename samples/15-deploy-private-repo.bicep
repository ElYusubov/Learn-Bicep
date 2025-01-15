// 15-deploy-private-repo.bicep

// Step-1: Create Azure container registry (ACR)
// Use the modules/acr-registry.bicep

// Step-2: Get the login server name of the ACR
// az acr login --name azwelshug0315

// Step-3: Publish a Bicep file as a module to a private module registry

// Step-4: Call the private module in your Bicep code

module regAppService 'br:cloudwithus01.azurecr.io/bicep/modules/appservice:v1.0.0' = {
  name: 'appServiceDeploy'
  params: {
    location: 'eastus2'
    appServiceAppName: 'cloudwithus-demo-01'
  }
}

// module regStorage 'br:cloudwithus01.azurecr.io/bicep/modules/storage:v1.0.0' = {
//   name: 'storageDeploy'
//   params: {
//     azureRegion: 'eastus2'
//     geoRedundancy: false
//     namePrefix: 'dev'
//   }
// }

// CloudRegistry
module regNewStorage 'br/CloudRegistry:storage:v1.0.0' = {
  name: 'storageDeploy2'
  params: {
    azureRegion: 'eastus2'
    geoRedundancy: false
    namePrefix: 'test'
  }
}
