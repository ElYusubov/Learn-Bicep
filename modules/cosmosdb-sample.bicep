// cosmosdb-sample.bicep

@description('Create a suffix based out of RG for repeatable deployments')
param suffix string = uniqueString(resourceGroup().id)

@description('The location that these Cosmos DB resources will be deployed to')
param azureRegion string = resourceGroup().location

@description('The name of our Cosmos DB Account')
param databaseName string = toLower('db-${suffix}')

@description('The name of our Cosmos DB Account')
param accountName string = toLower('cosmos-${suffix}')

// Cosmos DB account
resource cosmos 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
  name: accountName
  location: azureRegion
  properties: {
    enableFreeTier: true
    databaseAccountOfferType: 'Standard'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: azureRegion
      }
    ]
  }
  tags:{
    Project: 'Azure Cosmos demo'
    Environment: 'Demo'
  }
}

// Cosmos DB database
resource cosmosdb 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2020-04-01' = {
  parent: cosmos
  name: databaseName
  properties: {
    resource: {
      id: databaseName
    }
    options: {
      throughput: 400
    }
  }
  tags:{
    Project: 'Azure Cosmos demo'
    Environment: 'Demo'
  }
}
