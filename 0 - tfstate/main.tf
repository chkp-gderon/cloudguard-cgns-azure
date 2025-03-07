resource "random_string" "resource_code" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_resource_group" "this" {
  name     = "tfstate-nsg-rg"
  location = "West Europe"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
resource "azurerm_network_security_group" "this" {
  resource_group_name = azurerm_resource_group.this.name 
  location = azurerm_resource_group.this.location
  name = "we-cp-dsb-nsg"
}
resource "azurerm_network_security_rule" "out" {
  network_security_group_name = azurerm_network_security_group.this.name
  resource_group_name = azurerm_resource_group.this.name
  source_address_prefixes = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16","198.18.0.0/15"]
  source_port_range = "*" 
  name = "Allow-all-out"
  access = "Allow"
  protocol = "*"
  destination_port_range = "*"
  destination_address_prefix = "*"
  direction = "Outbound"
  priority = 110
}
resource "azurerm_network_security_rule" "in" {
  network_security_group_name = azurerm_network_security_group.this.name
  resource_group_name = azurerm_resource_group.this.name
  
  source_address_prefixes = concat(["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"], var.cp_addresses, var.fdb_addresses)
  source_port_range = "*" 
  name = "Allow-all-in"
  access = "Allow"
  protocol = "*"
  destination_port_range = "*"
  destination_address_prefix = "*"
  direction = "Inbound"
  priority = 110
}
resource "azurerm_network_security_rule" "ne-appgw-in" {
  network_security_group_name = azurerm_network_security_group.this.name
  resource_group_name = azurerm_resource_group.this.name
  source_address_prefix = "*"
  source_port_range = "*" 
  name = "Allow-appgw-high-ports-in"
  access = "Allow"
  protocol = "*"
  destination_port_range = "65200-65535"
  destination_address_prefix = "*"
  direction = "Inbound"
  priority = 130
}
