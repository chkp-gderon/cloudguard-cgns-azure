resource "azurerm_resource_group" "this" {
  location = var.location
  name = var.rg_name
}

resource "azurerm_virtual_network" "hub_this" {
  resource_group_name = azurerm_resource_group.this.name
  location = azurerm_resource_group.this.location
  name = var.hub_vnet_name
  address_space = var.hub_address_space
}

resource "azurerm_subnet" "hub_snets" {
    for_each = {
        for index, snet in var.hub_subnets:
        snet.name => snet
    }
    depends_on = [ azurerm_virtual_network.hub_this ]
    resource_group_name = azurerm_resource_group.this.name
    virtual_network_name = azurerm_virtual_network.hub_this.name 
    name = each.value.name
    address_prefixes = each.value.address_cidrs
}
resource "azurerm_virtual_network" "spoke_this" {
    for_each = {
      for index, vnet in var.spoke_vnets:
      vnet.name => vnet
    }
  resource_group_name = azurerm_resource_group.this.name
  location = azurerm_resource_group.this.location
  name = each.value.name 
  address_space = each.value.address_space
}
resource "azurerm_subnet" "spokes_this" {
    for_each = {
        for index, snet in var.spoke_subnets:
        snet.name => snet
    }
    depends_on = [ azurerm_virtual_network.spoke_this ]
    resource_group_name = azurerm_resource_group.this.name
    virtual_network_name = each.value.vnetname
    name = each.value.name
    address_prefixes = each.value.address_cidrs
}
