/* audit-resource-tag-and-value-format.bicep

The purpose of this Azure Policy is to ensure that resources within a subscription have a specific tag with a specific value format. 
This helps in maintaining governance, compliance, and organization of resources by enforcing tagging standards and ensuring that tag values adhere to a specified format.
*/ 

targetScope = 'subscription'

// Define the variables 
var policyName = 'audit-resource-tag-and-value-format-pd'
var policyDisplayName = 'Audit a tag and its value format on resources'
var policyDescription = 'Audits existence of a tag and its value format. Does not apply to resource groups.'

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
      tagFormat: {
        type: 'String'
        metadata: {
          displayName: 'Tag format'
          description: 'An expressions for \'like\' condition'
        }
      }
    }

    policyRule: {
      if: {
        field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]'
        notLike: '[parameters(\'tagFormat\')]'
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}

// Define the output
output policyName string = policy.properties.displayName
