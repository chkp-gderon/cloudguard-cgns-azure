data "azurerm_network_security_group" "we_nsg" {
    name = var.nsg_name
    resource_group_name = var.tfstats_nsg_name 
}

