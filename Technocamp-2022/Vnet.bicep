param Location string = resourceGroup().location
param fwNSGId string
param defaultNsgId string
param defaultRouteTableId string
param fwRouteTableid string

resource hubVnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: 'VNET-NOE-HUB'
  location: Location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

resource fwsubnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: 'firewallSubnet'
  parent: hubVnet
  properties: {
    addressPrefix: '10.0.1.0/27'
    networkSecurityGroup: {
      id: fwNSGId
    }
    routeTable: {
      id: fwRouteTableid
    }
  }
}

resource defaultsubnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: 'defaultSubnet'
  parent: hubVnet
  properties: {
    addressPrefix: '10.0.2.0/24'
    networkSecurityGroup: {
      id: defaultNsgId
    }
    routeTable: {
      id: defaultRouteTableId
    }
  }
}


