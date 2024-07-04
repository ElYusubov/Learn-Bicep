// @description('String value defined for test deployment')
// param stringValue string = 'deployment parameter'

// @description('Integere value defined for test deployment')
// param intValue int = 45

// var concatValues =  '${stringValue}AddToVar'
// var sumUpIntValues = intValue + 5


// @allowed([
//   'dev'
//   'test'
//   'prod'
// ])
// param environmentName string

// var environmentSettings = {
//   dev: {
//     instanceSize: 'Small'
//     instanceCount: 1
//   }
//   test: {
//     instanceSize: 'Small'
//     instanceCount: 2
//   }
//   prod: {
//     instanceSize: 'Large'
//     instanceCount: 4
//   }
// }

// output instanceSize string = environmentSettings[environmentName].instanceSize
// output instanceCount int = environmentSettings[environmentName].instanceCount

// output finalConcat string = concatValues
// output finalSumUp int = sumUpIntValues



//// - Code #2

// param suffix string = '001'
// var webAppName = concat('webapp-', suffix)



//// - Code #3

// param resourceName string = 'defaultResourceName'

// resource myResource 'Microsoft.Provider/resourceType@version' = {
//   name: resourceName
//   // additional resource properties
// }





//// - Code #4

// param location string = resourceGroup().location

// @allowed([
//   'dev'
//   'test'
//   'prod'
// ])
// param environmentName string = 'dev'

// param appServiceAppName string = 'app-bicepOrg-${environmentName}-${uniqueString(resourceGroup().id)}'
// param appServicePlanName string = 'plan-bicepOrg-${environmentName}-${uniqueString(resourceGroup().id)}'

// resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
//   name: appServiceAppName
//   // ...
// }

// resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
//   name: appServicePlanName
//   // ...
// }



//// - Code #5

// @minLength(3)
// @maxLength(24)
// param primaryStorageAccountName string = 'bopri${environmentName}${uniqueString(resourceGroup().id)}'

// @allowed([
//   'dev'
//   'test'
//   'prod'
// ])
// param environmentName string = 'dev'

// param location string = resourceGroup().location

// @minLength(3)
// @maxLength(24)
// param secondaryStorageAccountName string = 'bosec${environmentName}${uniqueString(resourceGroup().id)}'

// resource primaryStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
//   name: primaryStorageAccountName
//   location: location
//   // ...
// }

// resource secondaryStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
//   name: secondaryStorageAccountName
//   // ...
// }




//// - Code #6

// // Define a parameter with a name of a known function range
// param range int

// // Because of the naming condtion, we must use sys namespace to call the function.
// output result array = sys.range(1, range)
// // The second use of range refers to the parameter.
