param Location string
param vmIdentity string


resource keyvault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: 'KV-NOE-VMSecrets'
  location: Location
  properties: {
    sku: {
      family:  'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
    accessPolicies: [
      {
        objectId: vmIdentity
        permissions: {
          secrets: [
            'get'
          ]
        }
        tenantId: tenant().tenantId
      }
    ]
  }
}
