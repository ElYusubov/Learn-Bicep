// eventHubRoleAssignment.bicep

@description('The Name of the Event Hubs Namepace')
param eventHubNamespaceName string

@description('The Id of the Function App')
param functionAppId string

@description('The Principal Id of the Function App')
param functionAppPrincipalId string

var eventHubsDataReceiverRoleId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '2b629674-e913-4c01-ae53-ef4638d8f975')
var eventHubsDataSenderRoleId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a638d3c7-ab3a-418d-83e6-5f17a39d4fde')

// Event Hub Namespace
resource eventHub 'Microsoft.EventHub/namespaces@2021-11-01' existing = {
  name: eventHubNamespaceName
}

// Assign the Event Hubs Data Receiver and Data Sender roles to the Function App
resource eventHubsDataReceiverRole 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  scope: eventHub
  name: guid(eventHub.id, functionAppId, eventHubsDataReceiverRoleId)
  properties: {
    principalId: functionAppPrincipalId
    roleDefinitionId: eventHubsDataReceiverRoleId
    principalType: 'ServicePrincipal'
  }
}

// Assign the Event Hubs Data Sender role to the Function App
resource eventHubsDataSenderRole 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(eventHub.id, functionAppId, eventHubsDataSenderRoleId)
  scope: eventHub
  properties: {
    principalId: functionAppPrincipalId
    roleDefinitionId: eventHubsDataSenderRoleId
    principalType: 'ServicePrincipal'
  }
}
