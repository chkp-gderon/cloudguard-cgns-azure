resource "azurerm_network_interface" "hubvm_-nic" {
  name                = "hubvm_nic"
  location            = data.azurerm_virtual_network.hub_vnet.location
  resource_group_name = data.azurerm_resource_group.network_rg.name

  ip_configuration {
    name                          = "ifconfig1"
    subnet_id                     = data.azurerm_subnet.hub_mgmt.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.hub_vm_ip.id
    }
}

resource "azurerm_public_ip" "hub_vm_ip" {
  resource_group_name = data.azurerm_resource_group.network_rg.name
  name = var.hubvm_pip_name
  public_ip_prefix_id = data.azurerm_public_ip_prefix.hub_vm_ip_prefix.id
  location = data.azurerm_virtual_network.hub_vnet.location
  allocation_method = "Static"
  sku = "Standard"
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "my_storage_account" {
  name                     = "hubvm8768dkjhop1diag"
  location            = data.azurerm_virtual_network.hub_vnet.location
  resource_group_name = data.azurerm_resource_group.network_rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "hubvm" {
  name                  = "hubvm"
  location            = data.azurerm_virtual_network.hub_vnet.location
  resource_group_name = data.azurerm_resource_group.network_rg.name
  network_interface_ids = [azurerm_network_interface.hubvm_-nic.id]
  size                  = "Standard_DS1_v2"
  user_data = filebase64("./user-data.sh")
  # user_data = base64encode(file("js-user-data.sh"))
  os_disk {
    name                 = "myOsDisk"
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

  computer_name  = var.hubvm_name
  admin_username = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = azurerm_ssh_public_key.this.public_key
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }
}