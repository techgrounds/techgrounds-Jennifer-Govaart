param location string = resourceGroup().location //de locatie die gekoppeld is aan de resourcegroup
param vnet1Name string = 'Vnet1-WebServer'
param Vnet2Name string = 'Vnet2-ManServer'

param serviceEndPoints array = [
  {
      locations: [
        'westeurope'                   
               ]
      service: 'Microsoft.Storage'
           }
]

//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////Vnet1 WINDOWS WEBSERVER/////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////



//vnet1 voor webserver
resource Vnet1Web 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: vnet1Name
  location: location
  properties: {
    addressSpace: {
       addressPrefixes: [
        '10.10.10.0/24'                      
       ]  
    }           
  }
}  


//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////Vnet1 SUBNET1////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////



//subnets voor vnet 1
resource Subnet1Web 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: Vnet1Web 
  name: 'sub1web' 
  properties: {
     addressPrefix: '10.10.10.0/25'
     serviceEndpoints: serviceEndPoints
     networkSecurityGroup: {
       id: nsg1sub1vnet1.id
     }
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////Vnet1 SUBNET2////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
  

 //subnet2 voor vnet1
  resource Subnet2Web 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
    parent: Vnet1Web 
    name: 'sub2web'
    properties: {
       addressPrefix:'10.10.10.128/25'
       networkSecurityGroup: {
         id: nsg2sub2vnet1.id
       }
      }
    }




//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////Vnet1 NSG's Subnet 1 voor alle subnets gelijk/////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////


resource nsg1sub1vnet1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {  
  location: location
  name: 'nsg1web'    
  properties: {
    securityRules:[
      {
        properties:{
          description: 'SSH'
          access: 'Allow'
          direction: 'Inbound'
          priority: 1000
          protocol: 'Tcp'
          destinationAddressPrefix:'*'
          destinationPortRange:'22'
          sourceAddressPrefix:'*'
          sourcePortRange:'*'          
        }
      }
      {
        properties:{
          description: 'HTTP'
          access: 'Allow'
          direction: 'Inbound'
          priority: 500
          protocol: 'Tcp'
          destinationAddressPrefix:'*'
          destinationPortRange:'80'
          sourceAddressPrefix:'*'
          sourcePortRange:'*'
        }
      }
      {
        properties:{
        description: 'HTTPS'
          access: 'Allow'
          direction: 'Inbound'
          priority: 501
          protocol: 'Tcp'
          destinationAddressPrefix:'*'
          destinationPortRange:'443'
          sourceAddressPrefix:'*'
          sourcePortRange:'*'
        }
      }
    ]    
  }
dependsOn: [
    Vnet1Web
]
 }
     
 resource nsg2sub2vnet1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {  
   location: location
   name: 'nsg2web'      
   properties: {
     securityRules:[
       {
         properties:{
           description: 'SSH'
           access: 'Allow'
           direction: 'Inbound'
           priority: 1000
           protocol: 'Tcp'
           destinationAddressPrefix:'*'
           destinationPortRange:'22'
           sourceAddressPrefix:'*'
           sourcePortRange:'*'          
         }
       }
     ]    
   }
 dependsOn: [
     Vnet1Web
 ]
  }
     
        
/////////////////////////////////////////////////////////////////////////////////////
////////////////////////VNET2////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////





 @description('aanmaken van vnet2 voor management server')
 resource Vnet2Man 'Microsoft.Network/virtualNetworks@2022-11-01' = {
   name: Vnet2Name
   location: location
   properties: {
     addressSpace: {
        addressPrefixes: [
          '10.20.20.0/24'                  
        ]          
     }     
     subnets:[
      {
        name: 'sub1Man'
        properties:{
          addressPrefix: '10.20.20.0/25'
          networkSecurityGroup:{
            id: nsg1sub1man.id
          }
        }        
      }    
    ]    
   }   
 }  

 
//nsg vnet2 sub1
 resource nsg1sub1man 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
   location: location
   name: 'nsg1man'
   properties: {
    securityRules:[
      {
        properties:{
          description: 'SSH'
          access: 'Allow'
          direction: 'Inbound'
          priority: 1000
          protocol: 'Tcp'
          destinationAddressPrefix:'*'
          destinationPortRange:'22'
          sourceAddressPrefix:'*'
          sourcePortRange:'*'          
        }
      }
      {
        properties:{
        description: 'RDP'
          access: 'Allow'
          direction: 'Inbound'
          priority: 600
          protocol: 'Tcp'
          destinationAddressPrefix:'*'
          destinationPortRange:'3389'
          sourceAddressPrefix:'*'
          sourcePortRange:'*'  
        }    
      }
    ]    
  }
  }


///////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////PEERING 1 met 2//////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////




  @description('peering vnet1 met vnet2')
  resource peeringWebwithMan 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
    name: 'vnet1-to-vnet2'
    parent: Vnet1Web
    properties: {            
      allowForwardedTraffic: true
      allowGatewayTransit: true     
      remoteVirtualNetwork: {
       id: Vnet2Man.id
     }    
 }  
}
 


resource peeringManwithWeb 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-07-01' = {
  name: 'vnet2-to-vnet1'
  parent: Vnet2Man
  properties: {
    allowForwardedTraffic: true
    allowGatewayTransit: true   
    remoteVirtualNetwork: {
      id: Vnet1Web.id
    }
  }
}




output Subnet1webID string = resourceId('Microsoft.Network/VirtualNetworks/subnets', vnet1Name, 'sub1web')
output Subnet2webID string = resourceId('Microsoft.Network/VirtualNetworks/subnets', vnet1Name,'sub2web')
output Subnet1manID string = resourceId('Microsoft.Network/VirtualNetworks/subnets', Vnet2Name,'sub1man')
