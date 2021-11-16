// 11-deploy-sqldb-w-keyvault.bicep

@description('SQL Server name.')
@minLength(5)
param sqlServerName string

@minLength(5)
@description('Admin login name')
param adminLogin string

@description('Deployment subscription id')
param subscriptionId string

@minLength(3)
@description('Azure Resource Group that containes the Azure KeyVault resource.')
param kvResourceGroup string

@minLength(3)
@description('Azure KeyVault resource name.')
param kvName string

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: kvName
  scope: resourceGroup(subscriptionId, kvResourceGroup )
}

module sql '../modules/sqldb.bicep' = {
  name: 'deploySQL'
  params: {
    sqlServerName: sqlServerName
    location: 'eastus'
    adminLogin: adminLogin
    adminPassword: kv.getSecret('ExamplePassword')
  }
}
