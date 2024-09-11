//// - Code #8

// param location string = resourceGroup().location

// resource wpAci 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
//   name: 'wordpress-containerinstance'
//   location: location
//   properties: {
//     osType: 'Linux'
//     containers: [
//       {
//         name: 'wordpress'
//         properties: {
//           resources: {
//             requests: {
//               cpu: any('0.75')  // Convert numeric value to string
//               memoryInGB: any('1.5')
//             }
//           }
//         }
//       }
//     ]
//   }
// }



//// - Code #8

// param intToConvert int = 9
// param stringToConvert string = 'packt'
// param objectToConvert object = { b: 'i', c: 'p' }

// output intOutput array = array(intToConvert)
// output stringOutput array = array(stringToConvert)
// output objectOutput array = array(objectToConvert)



//// - Code #9

// concat(arg1, arg2, arg3, ...)

// param firstArray array = ['item1', 'item2', 'item3']
// param secondArray array = ['item7', 'item8', 'item9']

// output return array = concat(firstArray, secondArray)


// param environment string = 'prod'
// param resourceType string = 'web'
// param resourceName string = 'app'

// var concatenatedName = '${environment}-${resourceType}-${resourceName}'

// output resourceNameWithEnvironment string = concatenatedName


// param availableFruits array = ['apple', 'strawberry', 'orange', 'banana', 'pear']
// param desiredfruit string = 'orange'

// var hasDesiredFruit = contains(availableFruits, desiredfruit)

// output containsDesiredFruit bool = hasDesiredFruit


//// - Code #10 - Empty Function

param availableFruits array = []
param desiredfruit string = 'mango'

output arrayEmpty bool = empty(availableFruits)
output stringEmpty bool = empty(desiredfruit)


//// - Code #10 - Firts Function

param storageAccountNames array = [
  'myStorageAccount3'
  'myStorageAccount2'
  'myStorageAccount'
]

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: first(storageAccountNames)
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

//// - Code #11 - Flatten Function

