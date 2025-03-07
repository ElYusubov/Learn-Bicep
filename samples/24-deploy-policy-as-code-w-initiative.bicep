// 24-deploy-policy-as-code-w-initiative.bicep

targetScope = 'subscription'

param policySource string = 'ElYusubov/Learn-Bicep'
param policyCategory string = 'Custom'
param assignmentEnforcementMode string = 'Default'
param listOfAllowedLocations array = [
  'eastus'
  'eastus2'
  'westus'
  'westus2'
  'westus3'
  'centralus'
  'northcentralus'
  'southcentralus'
  'westcentralus'
]

param listOfAllowedSKUs array = [
  'Standard_B2ms'
  'Standard_B2s'
  'Standard_B4ms'
  'Standard_B4s'
  'Standard_D2s_v3'
  'Standard_D4s_v3'
]

var initiativeName = 'SpringCleanDemoInitiative'
var assignmentName = 'SpringCleanDemoAssignment'
var version = '0.1.1'

resource demoInitiative 'Microsoft.Authorization/policySetDefinitions@2024-05-01' = {
  name: initiativeName
  properties: {
    policyType: 'Custom'
    displayName: initiativeName
    description: '${initiativeName} via ${policySource}'
    metadata: {
      category: policyCategory
      source: policySource
      version: version
    }
    parameters: {
      listOfAllowedLocations: {
        type: 'Array'
        metadata: ({
          description: 'The List of Allowed Locations for Resource Groups and Resources.'
          strongtype: 'location'
          displayName: 'Allowed Locations'
        })
      }
      listOfAllowedSKUs: {
        type: 'Array'
        metadata: any({
          description: 'The List of Allowed SKUs for Virtual Machines.'
          strongtype: 'vmSKUs'
          displayName: 'Allowed Virtual Machine Size SKUs'
        })
      }
    }
    policyDefinitions: [
      {
        // Allowed US locations for resource groups
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988'
        parameters: {
          listOfAllowedLocations: {
            value: '[parameters(\'listOfAllowedLocations\')]'
          }
        }
      }
      {
        // Allowed Azure regions for resources
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c'
        parameters: {
          listOfAllowedLocations: {
            value: '[parameters(\'listOfAllowedLocations\')]'
          }
        }
      }
      {
        // Allowed virtual machine SKU sizes
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/cccc23c7-8427-4f53-ad12-b6a63eb452b3'
        parameters: {
          listOfAllowedSKUs: {
            value: '[parameters(\'listOfAllowedSKUs\')]'
          }
        }
      }      
    ]
  }
}

resource demoAssignment 'Microsoft.Authorization/policyAssignments@2024-05-01' = {
  name: assignmentName
  properties: {
    displayName: assignmentName
    description: '${assignmentName} via ${policySource}'
    enforcementMode: assignmentEnforcementMode
    metadata: {
      source: policySource
      version: version
    }
    policyDefinitionId: demoInitiative.id
    parameters: {
      listOfAllowedLocations: {
        value: listOfAllowedLocations
      }
      listOfAllowedSKUs: {
        value: listOfAllowedSKUs
      }
    }
  }
}

output initiativeID string = demoInitiative.id
output assignmentID string = demoAssignment.id
