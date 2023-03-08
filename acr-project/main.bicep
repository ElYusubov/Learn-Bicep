// module acrDeploy 'br:biceppart1privateregistry.azurecr.io/bicep/modules/acr:v3'= {
//   name: 'acrDeploy'
//   params: {
//     acrName: 'newacr5'
//   }
// }

// az bicep publish --file storage.bicep --target br:exampleregistry.azurecr.io/bicep/modules/storage:1.1.1

// az bicep publish --file .\Chapter03\private-registry\kineteco-storage.bicep --target br:kinetecodevregistry.azurecr.io/bicep/modules/storage:1.0.0

module acrDeploy 'br/KinetEcoBicep:acr:v3'= {
  name: 'acrDeploy'
  params: {
    acrName: 'newacr5'
  }
}
