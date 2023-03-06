// module acrDeploy 'br:biceppart1privateregistry.azurecr.io/bicep/modules/acr:v3'= {
//   name: 'acrDeploy'
//   params: {
//     acrName: 'newacr5'
//   }
// }

module acrDeploy 'br/KinetEcoBicep:acr:v3'= {
  name: 'acrDeploy'
  params: {
    acrName: 'newacr5'
  }
}
