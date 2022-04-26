targetScope = 'subscription'
param location string = 'WestEurope'

resource sqlauditpolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Audit SQL AllowAllAzureIps'
  properties: {
    description: 'Audit SQL server from having AllowAllAzureIps configured.'
    displayName: 'Audit SQL server AllowAllAzureIps'
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
        effect: 'audit'
      }
    }
  }
}

resource policyass 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Assign Audit AllowAllAzureIps Policy'
  location: location
  properties: {
    policyDefinitionId: sqlauditpolicy.id
    description: 'Audits the use of setting "AllowAllAzureIps"'
    nonComplianceMessages: [
      {
      message: 'AllowAllAzureIps setting is forbidden.'
      }
    ]
  }
}
