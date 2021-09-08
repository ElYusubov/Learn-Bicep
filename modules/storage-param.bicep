// storage.bicep

@description('The prefix that will appear infront of storage account name.')
@allowed([
  'cll21'
  'test21'
  'dev21'
])
param namePrefix string = 'cll21'

@description('The storage account name.')
@minLength(3)
@maxLength(24)
param paramStorageName string = '${namePrefix}${uniqueString(resourceGroup().id)}'
var stgName = toLower(paramStorageName)

@description('The flag that indicate need for a geo-redundant storage.')
param geoRedundancy bool

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: stgName
  location: resourceGroup().location
  kind: 'StorageV2' 
  sku: {
    name: geoRedundancy ? 'Standard_GRS' : 'Standard_LRS'
  }
}

// Note: enable lock for *** 3-Deploy.bicep *** demo case 

// resource lockResourceGroup 'Microsoft.Authorization/locks@2016-09-01' = {
//   name: 'DonDelete'
//   scope: storageAccount
//   properties: {
//     level: 'CanNotDelete'
//   }
// }

output storageId string = storageAccount.id // output resourceId of storage account
output blobEndpoint string = storageAccount.properties.primaryEndpoints.blob // [reference(cariables('storagename')).properties.primaryEndpoints.blob]
