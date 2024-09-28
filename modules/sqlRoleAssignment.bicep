// sqlRoleAssignment.bicep

@description('The name of the Cosmos DB account that we will use for SQL Role Assignments')
param cosmosDbAccountName string

@description('The Principal Id of the Function App that we will grant the role assignment to.')
param functionAppPrincipalId string

@description('The name of the Cosmos DB account that we will use for SQL Role Assignments')
var roleDefinitionId = guid('sql-role-definition-', functionAppPrincipalId, cosmosDbAccount.id)
var roleAssignmentId = guid(roleDefinitionId, functionAppPrincipalId, cosmosDbAccount.id)
var roleDefinitionName = 'Function Read Write Role'
var dataActions = [
  'Microsoft.DocumentDB/databaseAccounts/readMetadata'
  'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*'
] 

@description('The Cosmos DB account that we will use for SQL Role Assignments')
resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2021-11-15-preview' existing = {
  name: cosmosDbAccountName
}

// Create a custom role definition
resource sqlRoleDefinition 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2021-11-15-preview' = {
  parent: cosmosDbAccount
  name: roleDefinitionId
  properties: {
    roleName: roleDefinitionName
    type: 'CustomRole'
    assignableScopes: [
      cosmosDbAccount.id
    ]
    permissions: [
      {
        dataActions: dataActions
      }
    ]
  }
}

// Assign the custom role to the Function App
resource sqlRoleAssignment 'Microsoft.DocumentDB/databaseAccounts/sqlRoleAssignments@2021-11-15-preview' = {
  parent: cosmosDbAccount
  name: roleAssignmentId
  properties: {
    roleDefinitionId: sqlRoleDefinition.id
    principalId: functionAppPrincipalId
    scope: cosmosDbAccount.id
  }
}
