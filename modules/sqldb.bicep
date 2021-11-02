// sqldb.bicep

@minLength(12)
@secure()
param myPassword string

@description('Azure region to deploy all resources')
@allowed([
  'eastus'
  'eastus2'
  'westus'
  'westus2'
])
param location string

resource sqlserver 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: 'ContosoSqlServer'
  location: location
  properties: {
    administratorLogin: 'contosoadmin'
    administratorLoginPassword: myPassword
  }

  resource sqldb 'databases' = {
    name: 'contosodb'
    location: location
  }
}
