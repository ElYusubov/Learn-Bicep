targetScope = 'managementGroup'

@description('Azure Security Benchmark policy')
param policyDefinitionId string = '/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8'

@minLength(3)
param policyName string = 'Azure Key Vaults should use private link'

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: policyName
  location: 'eastus2'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    displayName: 'policyassignment1'
    description: 'policyassignment1'
    enforcementMode: 'Default'
    metadata: {
      source: 'source'
      version: '0.1.0'
    }
    policyDefinitionId: policyDefinitionId
    parameters: {
      secretsExpirationSetEffect: {
        value: 'Deny'
      }
      keysExpirationSetEffect: {
        value: 'Deny'
      }
    }
    nonComplianceMessages: [
      {
        message: 'Change is denied due to policyAssignment1'
      }
    ]
  }
}

output assignmentId string = policyAssignment.id
