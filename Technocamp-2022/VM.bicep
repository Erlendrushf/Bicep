param Location string
@secure()
param vmuserlogon string
@secure()
param vmuserpassword string
param subnetId string


resource vm1 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: 'VM1'
  location: Location
  properties: {
    osProfile: {
      adminUsername: vmuserlogon
      adminPassword: vmuserpassword
    }
    networkProfile: {
       networkInterfaces: [
           vm1nic
       ]
    }
  }
}

resource vm1nic 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: 'vm1-nic'
  properties: {
    ipConfigurations: [
      {
        name: 'DefaultIpConfig'
        properties: {
          publicIPAddress: {
            sku: {
              name: 'Standard'
              tier: 'Global'
            }
          }
          privateIPAddress: '10.0.2.5'
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}
