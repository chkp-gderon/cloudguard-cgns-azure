variable "tenant_id" {
  type = string
}  
variable "subscription_name" {
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
variable "location" {
    type = string  
}
variable "rg_name" {
  type = string
}
variable "hub_vnet_name" {
  type = string
}
variable "hub_address_space" {
  type = list(string)
}

variable "hub_subnets" {
  type = list(object({
    name = string
    address_cidrs = list(string)
  }))
}

variable "spoke_vnets" {
  type = list(object({
        name = string
        address_space = list(string)
  }))
}
variable "spoke_subnets" {
  type = list(object({
        vnetname = string
        name = string
        address_cidrs = list(string)
  }))
}
variable "piprefix_name" {
  type = string
}

variable "nsg_name" {
    type = string
} 
variable "tfstats_nsg_name" {
  type = string
}