param azureRegion string = resourceGroup().location
param templateSpecVersionName string = '0.2.0'

resource tempSpecStorage 'Microsoft.Resources/templateSpecs@2022-02-01' = {
  name: 'storageSpec'
  location: azureRegion
  properties: {
    description: 'A basic templateSpec - creates a storage account.'
    displayName: 'Storage account (Standard_LRS)'
  }
}

resource createTemplateSpecVersion 'Microsoft.Resources/templateSpecs/versions@2021-05-01' = {
  parent: tempSpecStorage
  name: templateSpecVersionName
  location: azureRegion
  properties: {
    mainTemplate: {
      '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      'contentVersion': '1.0.0.0'
      'parameters': {
        'storageAccountType': {
          'type': 'string'
          'defaultValue': 'Standard_LRS'
          'allowedValues': [
            'Standard_LRS'
            'Standard_GRS'
            'Standard_ZRS'
            'Premium_ZRS'
            'Premium_LRS'
          ]
        }
        'storageAccountName': {
          'type': 'string'
          'defaultValue': 'kinetecostg090078'
        }
      }
      'resources': [
        {
          'type': 'Microsoft.Storage/storageAccounts'
          'apiVersion': '2019-06-01'
          'name': '[parameters(\'storageAccountName\')]'
          'location': resourceGroup().location
          'kind': 'StorageV2'
          'sku': {
            'name': '[parameters(\'storageAccountType\')]'
          }
        }
      ]
    }
  }
}
