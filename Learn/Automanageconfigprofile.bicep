param Location string = resourceGroup().location

resource config 'Microsoft.Automanage/configurationProfiles@2021-04-30-preview' = {
  name: 'Demo-configuration-profile'
  location: Location
  properties: {
    configuration: {
      AntiMalwareEnable: true
      
    }
  }
}
