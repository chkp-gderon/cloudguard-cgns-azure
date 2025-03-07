location = "West Europe"
rg_name = "we-fdb-networking-rg"

hub_vnet_name = "we-fdb-hub-vnet"
hub_address_space = ["198.18.0.0/20"]

hub_subnets = [ 
    {
        name = "we-hub-mgmt-snet"
        address_cidrs = ["198.18.0.0/24"]
    },
    {
        name = "we-hub-fe-snet"
        address_cidrs = ["198.18.1.0/24"]
    },   
    {
        name = "we-hub-be-snet"
        address_cidrs = ["198.18.2.0/24"]
    }
]
spoke_vnets = [
    {
        address_space = [ "198.18.16.0/20" ]
        name = "we-fdb-spoke1-vnet"
    } ,{   
        address_space = [ "198.18.32.0/20" ]
        name = "we-fdb-spoke2-vnet"
    }
]
spoke_subnets = [
    {
        vnetname = "we-fdb-spoke1-vnet"
        name = "we-fdb-spoke1-mgmt-snet"
        address_cidrs = [ "198.18.16.0/24" ]
    },
    {
        vnetname = "we-fdb-spoke1-vnet"
        name = "we-fdb-spoke1-data-snet"
        address_cidrs = [ "198.18.17.0/24" ]
    },
    {
        vnetname = "we-fdb-spoke2-vnet"
        name = "we-fdb-spoke2-mgmt-snet"
        address_cidrs = [ "198.18.32.0/24" ]
    },
    {
        vnetname = "we-fdb-spoke2-vnet"
        name = "we-fdb-spoke2-data-snet"
        address_cidrs = [ "198.18.33.0/24" ]
    }
]

piprefix_name = "we-piprefix"

nsg_name = "we-cp-dsb-nsg"
tfstats_nsg_name = "tfstate-nsg-rg"