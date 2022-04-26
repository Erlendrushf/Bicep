targetScope = 'subscription'
param location string = 'WestEurope'

resource sqldenypolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny SQL AllowAllAzureIps'
  properties: {
    description: 'Deny SQL server from having AllowAllAzureIps configured.'
    displayName: 'Deny SQL server AllowAllAzureIps'
    mode: 'All'
    metadata: {
      category: 'SQL'
    }
    policyType: 'Custom'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Sql/servers/firewallRules'
          }
          {
            field: 'name'
            like: 'AllowAllWindowsAzureIps'
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

resource policyass 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Assign Deny AllowAllAzureIps Policy'
  location: location
  properties: {
    policyDefinitionId: sqldenypolicy.id
    description: 'Denies the use of setting "AllowAllAzureIps"'
    nonComplianceMessages: [
      {
      message: 'AllowAllAzureIps setting is forbidden.'
      }
    ]
    displayName: 'Deny SQL server AllowAllAzureIps'
  }
}
