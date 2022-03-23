
param fwpolicyname string
param priority int = 300
param sourceaddresses array

resource fwpolicy 'Microsoft.Network/firewallPolicies@2021-05-01' existing = {
  name: fwpolicyname
}

resource fwPolicyrulecollection 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2021-05-01' = {
  name: 'AllowAadConnect'
  parent: fwpolicy
  properties: {
    priority: priority
    ruleCollections: [
      {
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'
        action: {
          type: 'Allow'
        }
        rules: [
          {
            name: 'AAD Connect health Service Endpoints'
            ruleType: 'ApplicationRule'
            targetFqdns: [
              '*.aadconnecthealth.azure.com'
              '*servicebus.windows.net'
              '*.adhybridhealth.azure.com'
              'www.management.azure.com'
              'www.policykeyservice.dc.ad.msft.net'
              'secure.aadcdn.microsoftonline-p.com'
              'aadcdn.msftauth.net'
            ]
            sourceAddresses: sourceaddresses
            protocols: [
              {
                protocolType: 'Https'
                port: 443
              }
            ]
          }
          {
            name: 'Discovery'
            ruleType: 'ApplicationRule'
            targetFqdns: [
              'www.office.com'
            ]
            sourceAddresses: sourceaddresses
            protocols: [
              {
                protocolType: 'Https'
                port: 443
              }
            ]
          }
          {
            name: 'Sign in AAD'
            ruleType: 'ApplicationRule'
            targetFqdns: [
              '*.windows.net'
            ]
            sourceAddresses: sourceaddresses
            protocols: [
              {
                protocolType: 'Https'
                port: 443
              }
            ]
          }
          {
            name: 'Confidure and import/export AAD'
            ruleType: 'ApplicationRule'
            targetFqdns: [
              '*.microsoftonline.com'
            ]
            sourceAddresses: sourceaddresses
            protocols: [
              {
                protocolType: 'Https'
                port: 443
              }
            ]
          }
          {
            name: 'Auth'
            ruleType: 'ApplicationRule'
            targetFqdns: [
              '*.msappproxy.net'
            ]
            sourceAddresses: sourceaddresses
            protocols: [
              {
                protocolType: 'Https'
                port: 443
              }
            ]
          }
          {
            name: 'CRL'
            ruleType: 'ApplicationRule'
            targetFqdns: [
              '*.verisign.com'
              '*.entrust.net'
            ]
            sourceAddresses: sourceaddresses
            protocols: [
              {
                protocolType: 'Http'
                port: 80
              }
            ]
          }
          {
            name: 'Verify cert'
            ruleType: 'ApplicationRule'
            targetFqdns: [
              '*.crl3.digicert.com'
              '*.crl4.digicert.com'
              '*.ocsp.digicert.com'
              '*.www.d-trust.net'
              '*.root-c3-ca2-2009.ocsp.d-trust.net'
              '*.crl.microsoft.com'
              '*.oneocsp.microsoft.com'
              '*.ocsp.msocsp.com'
            ]
            sourceAddresses: sourceaddresses
            protocols: [
              {
                protocolType: 'Http'
                port: 80
              }
            ]
          }
        ]
      }
    ]
  }
}
