/*

audit-resource-tag-and-its-value-match.bicep

The purpose of this Azure Policy is to ensure that resources within a subscription have a specific tag with a specific value. 
This helps in maintaining governance, compliance, and organization of resources by enforcing tagging standards.
*/

targetScope = 'subscription'

// Define the variables
var policyName = 'audit-resource-tag-and-value-match-pd'
var policyDisplayName = 'Audit a tag and its value match on resources'
var policyDescription = 'Audits existence of a tag and its value match. Does not apply to resource groups.'

// Define the policy
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
      tagPattern: {
        type: 'String'
        metadata: {
          displayName: 'Tag pattern'
          description: 'An expressions for \'match\' condition'
        }
      }
    }

    policyRule: {
      if: {
        field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]'
        notMatch: '[parameters(\'tagPattern\')]'
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
