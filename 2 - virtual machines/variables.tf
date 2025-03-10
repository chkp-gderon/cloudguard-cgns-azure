variable "tenant_id" {
  type = string
}  
variable "subscription_id"{
    type = string
}
variable "client_id" {
  type = string
  sensitive = true
}
variable "client_secret" {
  type = string
  sensitive = true
}
variable "hub_vnet_name" {
  type = string
}
variable "hub_mgmt_snet_name" {
  type = string
}
variable "networking_rg_name" {
  type = string
}
variable "location" {
    type = string  
}
# variable "rg_name" {
#   type = string
# }

variable "hubvm_name" {
  type = string
}
variable "piprefix_name" {
  type = string
}
variable "hubvm_pip_name" {
  type = string
}

variable "spokes_vms" {
  type = list(object({
    vnet_name = string
    snet_name = string
    computer_name = string
  }))
}
# variable "diags" {
#   type = string
# }