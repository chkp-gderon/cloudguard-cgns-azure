hub_vnet_name = "we-fdb-hub-vnet"
hub_mgmt_snet_name = "we-hub-mgmt-snet"

networking_rg_name = "we-fdb-networking-rg"
hubvm_name = "we-hub-rocky9"

piprefix_name = "we-piprefix"
location = "West Europe"
hubvm_pip_name = "we-hubvm-public-ip"

spokes_vms = [
    {
        vnet_name = "we-fdb-spoke1-vnet"
        snet_name = "we-fdb-spoke1-data-snet"
        computer_name = "we-spoke1-rocky9-1"
    },
    {
        vnet_name = "we-fdb-spoke2-vnet"
        snet_name = "we-fdb-spoke2-data-snet"
        computer_name = "we-spoke2-rocky9-1"
    }
]