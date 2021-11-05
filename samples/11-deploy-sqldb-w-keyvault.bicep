
param sqlServerName string
param adminLogin string

param subscriptionId string
param kvResourceGroup string
param kvName string

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: kvName
  scope: resourceGroup(subscriptionId, kvResourceGroup )
}

module sql '../modules/sqldb.bicep' = {
  name: 'deploySQL'
  params: {
    sqlServerName: sqlServerName
    location: 'westus2'
    adminLogin: adminLogin
    adminPassword: kv.getSecret('ExamplePassword')
  }
}
