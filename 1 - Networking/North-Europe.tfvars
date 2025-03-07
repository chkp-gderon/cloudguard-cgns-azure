location = "North Europe"
rg_name = "ne-fdb-networking-rg"

hub_vnet_name = "ne-fdb-hub-vnet"
hub_address_space = ["198.19.0.0/20"]

hub_subnets = [ 
    {
        name = "ne-hub-mgmt-snet"
        address_cidrs = ["198.19.0.0/24"]
    },
    {
        name = "ne-hub-fe-snet"
        address_cidrs = ["198.19.1.0/24"]
    },   
    {
        name = "ne-hub-be-snet"
        address_cidrs = ["198.19.2.0/24"]
    }
]
spoke_vnets = [
    {
        address_space = [ "198.19.16.0/20" ]
        name = "ne-fdb-spoke1-vnet"
    } ,{   
        address_space = [ "198.19.32.0/20" ]
        name = "ne-fdb-spoke2-vnet"
    }
]
spoke_subnets = [
    {
        vnetname = "ne-fdb-spoke1-vnet"
        name = "ne-spoke1-mgmt-snet"
        address_cidrs = [ "198.19.16.0/24" ]
    },
    {
        vnetname = "ne-fdb-spoke1-vnet"
        name = "ne-fdb-spoke1-data-snet"
        address_cidrs = [ "198.19.17.0/24" ]
    },
    {
        vnetname = "ne-fdb-spoke2-vnet"
        name = "ne-fdb-spoke2-mgmt-snet"
        address_cidrs = [ "198.19.32.0/24" ]
    },
    {
        vnetname = "ne-fdb-spoke2-vnet"
        name = "ne-fdb-spoke2-data-snet"
        address_cidrs = [ "198.19.33.0/24" ]
    }
]

piprefix_name = "ne-piprefix"

nsg_name = "ne-cp-dsb-nsg"
tfstats_nsg_name = "tfstate-nsg-rg"