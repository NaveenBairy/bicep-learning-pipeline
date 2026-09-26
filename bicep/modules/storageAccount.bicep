@description('Base name to derive a unique storage account name from')
param namePrefix string = 'gnb'

@description('Azure region')
param location string

@description('Storage account SKU')
param skuName string = 'Standard_LRS'

@description('Tags to apply')
param tags object = {}

var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
  }
  tags: tags
}

output storageAccountName string = storageAccount.name
