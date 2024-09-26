// web-app-w-private-endpoint.bicep

param azureRegion string = resourceGroup().location
param webAppName string
param storageAccountName string

resource webApp 'Microsoft.Web/sites@2021-01-01' = {
    name: webAppName
    location: azureRegion
    properties: {
        serverFarmId: appServicePlan.id
    }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-01' = {
    name: '${webAppName}Plan'
    location: azureRegion
    sku: {
        name: 'F1'
        tier: 'Free'
    }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
    name: storageAccountName
    location: azureRegion
    sku: {
        name: 'Standard_LRS'
    }
    kind: 'StorageV2'
}

// Create a private endpoint for the web app
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-02-01' = {
    name: '${webAppName}PrivateEndpoint'
    location: azureRegion
    properties: {
        privateLinkServiceConnections: [
            {
                name: '${webAppName}PrivateLinkServiceConnection'
                properties: {
                    privateLinkServiceId: storageAccount.id
                    groupIds: [
                        'blob'
                    ]
                }
            }
        ]
        manualPrivateLinkServiceConnections: []
    }
}
