# Assign NSG's to subnets
resource "azurerm_subnet_network_security_group_association" "spokes_nsga" {
  for_each = azurerm_subnet.spokes_this
  subnet_id = each.value.id
  network_security_group_id = data.azurerm_network_security_group.we_nsg.id
}
resource "azurerm_subnet_network_security_group_association" "hub_nsga" {
  for_each = azurerm_subnet.hub_snets
  subnet_id = each.value.id
  network_security_group_id = data.azurerm_network_security_group.we_nsg.id
}




