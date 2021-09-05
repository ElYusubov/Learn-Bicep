// storage.bicep

@allowed([
  'school21'
  'test21'
  'stag21'
])
param namePrefix string = 'school21'

@minLength(3)
@maxLength(24)
param paramStorageName string = '${namePrefix}${uniqueString(resourceGroup().id)}'
var stgName = toLower(paramStorageName)

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
