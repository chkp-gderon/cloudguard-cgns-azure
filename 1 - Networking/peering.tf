#Peering between hub and spokes
resource "azurerm_virtual_network_peering" "hub_to_spokes" {
    for_each = azurerm_virtual_network.spoke_this
    depends_on = [ azurerm_virtual_network.spoke_this, azurerm_virtual_network.hub_this  ]
  name                      = join ("-", ["hub", "to", each.value.name, "vnetp"])
  resource_group_name = azurerm_resource_group.this.name 
  virtual_network_name      = azurerm_virtual_network.hub_this.name
  remote_virtual_network_id = each.value.id
}
#Peering between spokes and hub
resource "azurerm_virtual_network_peering" "spokes_to_hub" {
    for_each = azurerm_virtual_network.spoke_this
    depends_on = [ azurerm_virtual_network.spoke_this, azurerm_virtual_network.hub_this  ]
  name                      = join ("-", [each.value.name, "to", "hub",  "vnetp"])
  resource_group_name = azurerm_resource_group.this.name 
  virtual_network_name      = each.value.name
  remote_virtual_network_id = azurerm_virtual_network.hub_this.id
}
