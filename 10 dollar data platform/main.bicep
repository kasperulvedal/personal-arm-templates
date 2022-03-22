targetScope = 'resourceGroup'
param location string = 'westeurope'

param companyName string = 'contoso'
param environmentType string = 'prod'

/*
Key Store
Storage
SQL DB
Data Factory
DevOps

vnet
*/

/* Storage account used for storage of various data files */
resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'st${companyName}dataplatform1'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
}

/* SQL Server and Database */
resource sqlServer 'Microsoft.Sql/servers@2014-04-01' ={
  name: 'sql-${companyName}-${environmentType}'
  location: location
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2014-04-01' = {
  parent: sqlServer
  name: 'sqldb-dataplatform-${environmentType}'
  location: location
  properties: {
    collation: 'collation'
    edition: 'Basic'
    maxSizeBytes: 'maxSizeBytes'
    requestedServiceObjectiveName: 'Basic'
  }
}

resource symbolicname 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: 'adf-dataplatform-${environmentType}'
  location: location
  identity: {
    type: 'string'
    userAssignedIdentities: {}
  }
  properties: {
    encryption: {
      identity: {
        userAssignedIdentity: 'string'
      }
      keyName: 'string'
      keyVersion: 'string'
      vaultBaseUrl: 'string'
    }
    globalParameters: {}
    publicNetworkAccess: 'string'
    repoConfiguration: {
      accountName: 'string'
      collaborationBranch: 'string'
      lastCommitId: 'string'
      repositoryName: 'string'
      rootFolder: 'string'
      type: 'string'
      // For remaining properties, see FactoryRepoConfiguration objects
    }
  }
}
