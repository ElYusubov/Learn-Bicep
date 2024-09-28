// sqldb.bicep

@description('Admin user login name.')
param adminLogin string = 'contosoadmin'

@description('SQL Server name.')
param sqlServerName string = 'ContosoSqlServer114'

@description('Admin user password. Must contain at least 12 characters.')
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
param azureRegion string

// SQL Server and SQL Database
resource sqlserver 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: sqlServerName
  location: azureRegion
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
  }

  resource sqldb 'databases' = {
    name: 'contosodb'
    location: azureRegion
  }
}
