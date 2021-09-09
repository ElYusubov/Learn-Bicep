// 8-deploy-firewall-w-ip-prefix.bicep

@description('Specifies the Azure location where the key vault should be created.')
param location string

@description('Specifies the name of the VNet.')
param vnetName string

@description('Specifies the address prefix to use for the VNet.')
param vnetAddressPrefix string

@description('Specifies the address prefix to use for the AzureFirewallSubnet')
param firewallSubnetPrefix string

@allowed([
  28
  29
  30
  31
])
@description('Specifies the size of the Public IP Prefix')
param ipprefixlength int = 31

var firewallname = '${vnetName}-fw'
var publicipname = '${vnetName}-pip'
var ipprefixname = '${vnetName}-ipprefix'

resource vnet 'Microsoft.Network/virtualNetworks@2020-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: firewallSubnetPrefix
        }
      }
    ]
  }
}

resource ipprefix 'Microsoft.Network/publicIPPrefixes@2020-05-01' = {
  name: ipprefixname
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    prefixLength: ipprefixlength
    publicIPAddressVersion: 'IPv4'
    ipTags: []
  }
}

resource publicip 'Microsoft.Network/publicIPAddresses@2020-05-01' = {
  name: publicipname
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPPrefix: {
      id: ipprefix.id
    }
  }
}

resource firewall 'Microsoft.Network/azureFirewalls@2020-05-01' = {
  name: firewallname
  location: location
  properties: {
    threatIntelMode: 'Alert'
    ipConfigurations: [
      {
        name: '${firewallname}-vnetIpconf'
        properties: {
          subnet: {
            id: '${vnet.id}/subnets/AzureFirewallSubnet'
          }
          publicIPAddress: {
            id: publicip.id
          }
        }
      }
    ]
  }
}
