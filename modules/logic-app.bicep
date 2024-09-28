// logic-app.bicep

@description('The location that these Logic App resources will be deployed to')
param azureRegion string = resourceGroup().location

@description('The Name of the Logic App')
param logicAppName string

@description('The Logic App definition')
param logicAppDefinition object

// Basic Logic App
resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicAppName
  location: azureRegion
  properties: {
    state: 'Enabled'
    definition: logicAppDefinition.definition
    parameters: logicAppDefinition.parameters
  }
}

// New logic app
resource logicAppNew 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'name'
  location: azureRegion
  properties: {
    definition: {
      '': 'https://schema.management.azure.com/schemas/2016-06-01/Microsoft.Logic.json'
      contentVersion: '1.0.0.0'
    }
  }
}

