data "azurerm_subnet" "hub_mgmt" {
  resource_group_name = var.networking_rg_name
  virtual_network_name = var.hub_vnet_name
  name = var.hub_mgmt_snet_name
}
data "azurerm_resource_group" "network_rg" {
  name = var.networking_rg_name
}
data "azurerm_virtual_network" "hub_vnet" {
  resource_group_name = var.networking_rg_name
  name = var.hub_vnet_name 
}
data "azurerm_public_ip_prefix" "hub_vm_ip_prefix" {
  resource_group_name = var.networking_rg_name
  name = var.piprefix_name
}

