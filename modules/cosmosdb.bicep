// cosmosdb.bicep

@description('The location that these Cosmos DB resources will be deployed to')
param location string

@description('The name of our Cosmos DB Account')
param cosmosDbAccountName string

@description('The name of our Database')
param databaseName string

@description('The name of our container')
param containerName string

@minValue(400)
@maxValue(10000)
@description('The amount of throughput to provision in our Cosmos DB Container')
param containerThroughput int

// Cosmos DB account
resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2021-11-15-preview' = {
  name: cosmosDbAccountName
  location: location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: true
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}

// Cosmos DB database
resource database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-11-15-preview' = {
  name: databaseName
  parent: cosmosDbAccount
  properties: {
    resource: {
      id: databaseName
    }
  }
}

// Cosmos DB container
resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-11-15-preview' = {
  name: containerName
  parent: database
  properties: {
    options: {
      throughput: containerThroughput
    }
    resource: {
      id: containerName
      partitionKey: {
        paths: [
          '/id'
        ]
        kind: 'Hash'
      }
      indexingPolicy: {
        indexingMode: 'consistent'
        includedPaths: [
          {
            path: '/*'
          }
        ]
      }
    }
  }
}

// Output values
output cosmosDbAccountName string = cosmosDbAccount.name
output databaseName string = database.name
output containerName string = container.name
output cosmosDbEndpoint string = cosmosDbAccount.properties.documentEndpoint
