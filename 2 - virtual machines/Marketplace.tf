resource "azurerm_marketplace_agreement" "rocky_9base_agreement" {
  publisher = "resf"
  offer     = "rockylinux-x86_64"
  plan      = "9-base"
}