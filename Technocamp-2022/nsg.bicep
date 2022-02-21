resource fwNSG 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: 'NSG-NOE-Firewall'
  properties: {
    securityRules: []
  }
}

resource DefaultNSG 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: 'NSG-NOE-Default'
  properties: {
    securityRules: []
  }
}


output fwNsgId string = fwNSG.id
output defaultNsgId string = DefaultNSG.id
