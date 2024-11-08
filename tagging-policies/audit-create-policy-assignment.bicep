// audit-create-policy-assignment.bicep

// Set variables for the policy definition
param policyName string
param policyDisplayName string
param policyDescription string
param policyDefinitionId string

var policyAssignmentName = '${policyName}-assignment'

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: policyAssignmentName
  properties: {
    policyDefinitionId: policyDefinitionId
    displayName: policyDisplayName
    description: policyDescription
    parameters: {
      tagName: {
        value: 'Environment'
      }
      tagPattern: {
        value: 'Test'
      }
    }
  }
}
