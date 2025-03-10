module "rocky_vm" {
  source = "./spoke_vms"
  diags = azurerm_storage_account.my_storage_account.name 
  rg_name = data.azurerm_resource_group.network_rg.name
  ssh_key_name = azurerm_ssh_public_key.this.name
  for_each =  { 
    for index, vm in var.spokes_vms:
        vm.computer_name => vm 
    }
  vnet_name = each.value.vnet_name
  snet_name = each.value.snet_name
  computer_name = each.value.computer_name
  # providers = {
  #   azurerm = azurerm
  # }

}
