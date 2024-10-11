// vm-win.bicep
// builds windows VM from provided SKUs

@description('An admin username for the VM.')
param adminUserName string

@description('The password for the VM. Must adhere to the complexity requirements for Windows VMs.')
@secure()
@minLength(12)
param adminPassword string

@description('The DNS label prefix for the Public IP Address associated with the VM.')
param dnsLabelPrefix string

param moduleTags object = {
  Project: 'Azure Demo Meetup'
  Environment: 'Demo'
}

@allowed([
  '2008-R2-SP1'
  '2012-Datacenter'
  '2012-R2-Datacenter'
  '2016-Nano-Server'
  '2016-Datacenter-with-Containers'
  '2016-Datacenter'
  '2019-Datacenter'
])
@description('The Windows version for the VM. This will pick a fully patched image of this given Windows version.')
param windowsOSVersion string = '2016-Datacenter'

@allowed([
  'Basic_A2'
  'Basic_A3'
  'Standard_A1_v2'
  'Standard_A2_v2'
  'Standard_B2ms'
  'Standard_B2s'
  'Standard_D1_v2'
  'Standard_D2_v2'
  'Standard_D2_v3'
])
@description('Size of the virtual machine.')
param vmSize string = 'Standard_B2ms'

@description('location for all resources')
param location string = resourceGroup().location

@description('Unique identifier for the storage resource.')
var storageAccountName = '${uniqueString(resourceGroup().id)}sawinvm'
var nicName = 'myVMNic'
var addressPrefix = '10.0.0.0/16'
var subnetName = 'Subnet'
var subnetPrefix = '10.0.0.0/24'
var publicIPAddressName = 'myDemoPublicIP'
var vmName = 'SimpleDemoWinVM'
var virtualNetworkName = 'demoVNET'
var subnetRef = '${vn.id}/subnets/${subnetName}'
var networkSecurityGroupName = 'demo-NSG'

// Create a storage account for the VM
resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
  tags: moduleTags
}

// Create a public IP address for the VM
resource pip 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: publicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: dnsLabelPrefix
    }
  }
  tags: moduleTags
}

// Create a network security group for the VM
resource sg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-3389'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

// Create a virtual network for the VM
resource vn 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
          networkSecurityGroup: {
            id: sg.id
          }
        }
      }
    ]
  }
  tags: moduleTags
}

// Create a network interface for the VM
resource nInter 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: nicName
  location: location
  tags: moduleTags

  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip.id
          }
          subnet: {
            id: subnetRef
          }
        }
      }
    ]
  }
}

// Create the VM resource
resource VM 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmName
  location: location
  tags: moduleTags
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUserName
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: windowsOSVersion
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: [
        {
          diskSizeGB: 1023
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nInter.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: stg.properties.primaryEndpoints.blob
      }
    }
  }
}

// Output the hostname for the VM
output hostname string = pip.properties.dnsSettings.fqdn
