@description('Name of the Event Hubs Namespace')
param eventHubsName string

@description('The location to deploy the Event Hub Namespace to')
param location string

@description('The SKU that we will provision this Event Hubs Namespace to.')
param eventHubsSkuName string

@description('The name of our event hub that we will provision as part of this namespace')
param hubName string

resource eventHubNamespace 'Microsoft.EventHub/namespaces@2021-11-01' = {
  name: eventHubsName
  location: location
  sku: {
    name: eventHubsSkuName
  }
  identity: {
    type: 'SystemAssigned'
  }
}

resource eventHub 'Microsoft.EventHub/namespaces/eventhubs@2021-11-01' = {
  name: hubName
  parent: eventHubNamespace
  properties: {
    messageRetentionInDays: 1
  }
}

output eventHubNamespaceName string = eventHubNamespace.name
output eventHubNamespaceId string = eventHubNamespace.id
output eventHubName string = eventHub.name
