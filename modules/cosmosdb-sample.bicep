// cosmosdb-sample.bicep

param appName string = uniqueString(resourceGroup().id)
param accountName string = toLower('cosmos-${appName}')
param location string = resourceGroup().location
param databaseName string = toLower('db-${appName}')

resource cosmos 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
  name: accountName
  location: location
  properties: {
    enableFreeTier: true
    databaseAccountOfferType: 'Standard'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: location
      }
    ]
  }
  tags:{
    Project: 'Azure Cosmos demo'
    Environment: 'Demo'
  }
}

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
