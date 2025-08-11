 // 25-graph-bicep-extension.bicep
 
extension microsoftGraphV1

param location string = resourceGroup().location

// Create a new Entra ID security group using Microsoft Graph extension
resource newGroup 'Microsoft.Graph/groups@v1.0' = {
  displayName: 'Demo group-01'
  mailEnabled: false
  mailNickname: 'new-demo-group-01'
  securityEnabled: true
  uniqueName: 'myAzureDemoGroup01'
  owners: {
    relationships: [managedIdentity.properties.principalId]
  }
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: 'demoGraphGroupMI'
  location: location
}
