resource "azurerm_network_interface" "this" {
  name                = join("-", [var.computer_name, "nic"])
  location            = data.azurerm_virtual_network.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  ip_configuration {
    name                          = "ifconfig1"
    subnet_id                     = data.azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    }
}

# # Create storage account for boot diagnostics
# resource "azurerm_storage_account" "my_storage_account" {
#   name                     = "hubvm8768dkjhop1diag"
#   location            = data.azurerm_virtual_network.this.location
#   resource_group_name = data.azurerm_resource_group.this.name
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# Create virtual machine
resource "azurerm_linux_virtual_machine" "this" {
  name                  = var.computer_name
  location            = data.azurerm_virtual_network.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  network_interface_ids = [azurerm_network_interface.this.id]
  size                  = "Standard_DS1_v2"
  user_data = filebase64("./user-data.sh")
  os_disk {
    name                 = join("-", [var.computer_name, "myOsDisk"])
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    # from az vm image list --output table --publisher resf --all 
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-base"
    version   = "latest"
  }
   plan {
    name = "9-base"
    product = "rockylinux-x86_64"
    publisher = "resf"
  }

  computer_name  = var.computer_name
  admin_username = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = data.azurerm_ssh_public_key.this.public_key
  }

  boot_diagnostics {
    storage_account_uri = data.azurerm_storage_account.this.primary_blob_endpoint
  }
}