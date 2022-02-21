param Location string

resource fwRoutetable 'Microsoft.Network/routeTables@2021-05-01' = {
  name: 'RT-NOE-Firewall'
  location: Location
  properties: {
    routes: [
      
    ]
  }
}

resource defaultRouteTable 'Microsoft.Network/routeTables@2021-05-01' = {
  name: 'RT-NOE-Deafult'
  location: Location
  properties: {
  }
}

resource routeToFirewall 'Microsoft.Network/routeTables/routes@2021-05-01' = {
  name: 'routeToFirewall'
  parent: defaultRouteTable
  properties: {
    nextHopType: 'VirtualAppliance'
    addressPrefix: '0.0.0.0/0'
    nextHopIpAddress: '10.0.1.5'
  }
}

resource defaultRoute 'Microsoft.Network/routeTables/routes@2021-05-01' = {
  name: 'defaultRoute'
  parent: fwRoutetable
  properties: {
    nextHopType: 'Internet'
    addressPrefix: '0.0.0.0/0'
  }
}

output fwRouteTableId string = fwRoutetable.id
output defaultRouteTableId string = defaultRouteTable.id
