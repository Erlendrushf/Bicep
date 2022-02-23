param Location string

var RSG = [
  'RSG-NOE-Network'
  'RSG-NOE-App1'
  'RSG-NOE-SharedResources'
]

targetScope = 'subscription'
resource resourceG 'Microsoft.Resources/resourceGroups@2021-04-01' = [for i in RSG: {
  name: i
  location: Location
}]

output resourcegroups  array = [for i in RSG: {
  name: resourceG[i].name
}]
