targetScope = 'subscription'
param location string = 'WestEurope'

resource sqlauditpolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny SQL AllowAllAzureIps'
  location: location
  properties: {
    description: 'Deny SQL server from having AllowAllAzureIps configured.'
    displayName: 'Deny SQL server AllowAllAzureIps'
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
    policyType: 'Custom'
  }
}

resource policyass 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Assign Deny AllowAllAzureIps Policy'
  location: location
  properties: {
    policyDefinitionId: sqlauditpolicy.id
    description: 'Denies the us of setting "AllowAllAzureIps"'
    nonComplianceMessages: [
      {
      message: 'AllowAllAzureIps setting is forbidden.'
      }
    ]
  }
}
