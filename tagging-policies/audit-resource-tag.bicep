// audit-resource-tag.bicep

// Set the scope of the deployment
targetScope = 'subscription'

// Set variables for the policy definition
var policyName = 'audit-resource-tag-pd'
var policyDisplayName = 'Audit a tag on resources'
var policyDescription = 'Audits existence of a tag. Does not apply to resource groups.'

// Create the policy definition
resource policy 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: policyName
  properties: {
    displayName: policyDisplayName
    description: policyDescription
    policyType: 'Custom'
    mode: 'Indexed'
    metadata: {
      category: 'Tags'
    }

    parameters: {
      tagName: {
        type: 'String'
        metadata: {
          displayName: 'Tag name'
          description: 'A tag to audit'
        }
      }
    }
    policyRule: {
      if: {
        field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]'
        exists: false
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}

// Create the policy assignment
module policyAssignment 'audit-create-policy-assignment.bicep' = {
  scope: resourceGroup()  // investigate if this should be subscription
  name: 'policyDeployment-${uniqueString(subscription().subscriptionId)}'
  params: {
    policyName: policyName
    policyDisplayName: policyDisplayName
    policyDescription: policyDescription
    policyDefinitionId: policy.id
  }
}
