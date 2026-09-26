// test change to trigger pipeline
targetScope = 'subscription'

@description('Name of the resource group to create')
param resourceGroupName string = 'rg-learning-demo'

@description('Azure region')
param location string = 'eastus'

@description('Tags applied to everything this template creates')
param tags object = {
  env: 'learning'
}

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

module storage 'modules/storageAccount.bicep' = {
  name: 'deploy-storage'
  scope: rg
  params: {
    location: location
    tags: tags
  }
}

output resourceGroupId string = rg.id
output storageAccountName string = storage.outputs.storageAccountName
