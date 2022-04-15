// Parameters
param location string = resourceGroup().location
param logicAppName string
param logicAppDefinition object

// Basic logic app
resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicAppName
  location: location
  properties: {
    state: 'Enabled'
    definition: logicAppDefinition.definition
    parameters: logicAppDefinition.parameters
  }
}

// Deployment steps on

resource logicAppNew 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'name'
  location: location
  properties: {
    definition: {
      '': 'https://schema.management.azure.com/schemas/2016-06-01/Microsoft.Logic.json'
      contentVersion: '1.0.0.0'
    }
  }
}

