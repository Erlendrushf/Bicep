param Location string = resourceGroup().location



module nsg 'nsg.bicep' = {
  name: 'networkSecurityGroups'
}

module vnet 'Vnet.bicep' = {
  name: 'virtualNetworks'
  dependsOn: [
    nsg
    routetable
  ]
  params: {
    Location: Location
    fwNSGId: nsg.outputs.fwNsgId
    fwRouteTableid: routetable.outputs.fwRouteTableId
    defaultNsgId: nsg.outputs.defaultNsgId
    defaultRouteTableId: routetable.outputs.defaultRouteTableId
  }
}

module routetable 'RouteTable.bicep' = {
  name: 'routeTable'
  params: {
    Location: Location
  }
}

module VM 'VM.bicep' = {
  name: 'virtualMachine'
  dependsOn: [
    vnet
  ]
  params: {
    Location: Location
  }
}

