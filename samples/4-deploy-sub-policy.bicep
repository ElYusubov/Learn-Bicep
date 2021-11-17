// 4-deploy-sub-policy.bicep

targetScope = 'subscription'

param listOfAllowedLocations array = [
  'eastus'
  'eastus2'
  'westus'
  'westus2'
]

@allowed([
  'Audit'
  'Deny'
])
param policyEffect string

resource locationPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'Allowed-location-eastus-eastus2'
  properties: {
    displayName: 'Custom - allowed location for resources'
    policyType: 'Custom'
    description: 'Use policy to restrict resource deployment to EastUS and EastUS2 locations'
    parameters: {
      allowedLocations: {
        type: 'Array'
      }
      effect: {
        type: 'String'
      }
    }
    metadata: {
      category: 'Locations'
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'location'
            notIn: '[parameters(\'allowedLocations\')]'
          }
          {
            field: 'location'
            notEquals: 'global'
          }
          {
            field: 'type'
            notEquals: 'Microsoft.AzureActiveDirectory/b2cDirectories'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}

resource locationPolicy 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: 'Resource-location-restriction'
  properties: {
    policyDefinitionId: locationPolicyDefinition.id
    displayName: 'Restrict location for Azure resources'
    description: 'Policy will either Audit or Deny resources being deployed in other locations'
    parameters: {
      allowedLocations: {
        value: listOfAllowedLocations
      }
      Effect: {
        value: policyEffect
      }
    }
  }
}
