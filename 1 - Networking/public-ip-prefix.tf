resource "azurerm_public_ip_prefix" "this" {
  location = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name 
  name = var.piprefix_name
  prefix_length = 28
  ip_version = "IPv4"
  sku = "Standard"
}

