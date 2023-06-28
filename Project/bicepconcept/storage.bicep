param storageAccountName string = 'storage1${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location


resource storeAcc 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties:{
    accessTier: 'Hot'
    allowBlobPublicAccess: true
     publicNetworkAccess: 'Enabled'
     
  }
}


resource blobservice 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
 parent: storeAcc
  name: 'default'
   properties: {
     
   }
}


resource folder 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: blobservice
  name: 'folder1'
   properties: {
    publicAccess:'Blob'
   }
}













