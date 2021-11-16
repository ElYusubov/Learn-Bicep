// sqldb.bicep
@description('Admin user login name.')
param adminLogin string = 'contosoadmin'

@description('SQL Server name.')
param sqlServerName string = 'ContosoSqlServer114'

@minLength(12)
@secure()
param adminPassword string

@description('Azure region to deploy all resources')
@allowed([
  'eastus'
  'eastus2'
  'westus'
  'westus2'
])
param location string

resource sqlserver 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
  }

  resource sqldb 'databases' = {
    name: 'contosodb'
    location: location
  }
}
