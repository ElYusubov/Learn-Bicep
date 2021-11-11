targetScope = 'managementGroup'

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'assignpolicy'
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
    policyDefinitionId: 'policyDefinitionId'
    parameters: {
      parameterName: {
        value: 'value'
      }
    }
    nonComplianceMessages: [
      {
        message: 'message'
      }
      {
        message: 'message'
        policyDefinitionReferenceId: 'policyDefinitionReferenceId'
      }
    ]
  }
}

