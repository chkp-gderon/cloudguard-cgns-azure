data "azurerm_subnet" "this" {
  resource_group_name = var.rg_name
  virtual_network_name = var.vnet_name
  name = var.snet_name 
}
data "azurerm_virtual_network" "this" {
  resource_group_name = var.rg_name
  name = var.vnet_name
}
data "azurerm_ssh_public_key" "this" {
  resource_group_name = var.rg_name
  name = var.ssh_key_name
}
data "azurerm_resource_group" "this" {
  name = var.rg_name
}
data "azurerm_storage_account" "this" {
  name = var.diags
  resource_group_name = var.rg_name
}