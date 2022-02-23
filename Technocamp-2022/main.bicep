param Location string = resourceGroup().location
@secure()
param vmuserlogon string
@secure()
param vmuserpassword string


var resourcegroups = [
  'RSG-NOE-Network'
  'RSG-NOE-App1'
  'RSG-NOE-SharedResources'
]

module rsg 'RSG.bicep' = {
  scope: subscription()
  name: 'resourceGroups'
  params: {
    Location: Location
  }
}

module nsg 'nsg.bicep' = {
  dependsOn: [
    rsg
  ]
  scope: resourceGroup(resourcegroups[0])
  name: 'networkSecurityGroups'
}

module vnet 'Vnet.bicep' = {
  name: 'virtualNetworks'
  dependsOn: [
    nsg
    routetable
  ]
  scope: resourceGroup(resourcegroups[0])
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
  scope: resourceGroup(resourcegroups[0])
  params: {
    Location: Location
  }
}

module VM 'VM.bicep' = {
  name: 'virtualMachine'
  dependsOn: [
    vnet
  ]
  scope: resourceGroup(resourcegroups[1])
  params: {
    Location: Location
    vmuserlogon: vmuserlogon
    vmuserpassword: vmuserpassword
    subnetId: vnet.outputs.subnetId
  }
}

module keyvault 'Keyvault.bicep' = {
  name: 'keyVault'
  scope: resourceGroup(resourcegroups[2])
}
