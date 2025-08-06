extension microsoftGraphV1

param location string = resourceGroup().location

resource newGroup 'Microsoft.Graph/groups@v1.0' = {
  displayName: 'Demo group'
  mailEnabled: false
  mailNickname: 'new-demo-group'
  securityEnabled: true
  uniqueName: 'myDemoGroup'
  owners: {
    relationships: [managedIdentity.properties.principalId]
  }
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: 'demoManagedIdentity'
  location: location
}
