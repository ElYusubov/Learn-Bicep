// private-modules.bicep


// Deploying the private web app module
module privateWebApp 'br/PrivateDemo:webapp:v2.0.0'= {
  name: 'privateWebApp-Deploy1'
  params: {
    location: 'westus'
  }
}

// Deploying the private storage module
module privateStorage 'br/PrivateDemo:storage:v1.1.0'= {
  name: 'privateStorage-deploy2'
  params:{
    azureRegion: resourceGroup().location
    geoRedundancy: false
    paramStorageName: 'weneednewstg78464'
    namePrefix: 'test'
  }
}
