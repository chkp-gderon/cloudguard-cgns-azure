resource "checkpoint_management_dynamic_object" "LocalGatewayExternal" {
  name = "LocalGatewayExternal"
  comments = "VMSS instace external (eth0) IP."
  color = "yellow"
}
resource "checkpoint_management_dynamic_object" "LocalGatewayInternal" {
  name = "LocalGatewayInternal"
  comments = "VMSS instace internal (eth1) IP."
  color = "yellow"
}
resource "checkpoint_management_host" "this" {
  for_each = {
    for index, host in var.cp_hosts:
    host.name  => host
  }
  name = each.value.name
  ipv4_address = each.value.ipv4
}
resource "checkpoint_management_network" "this" {
  for_each = {
    for index, net in var.cp_nets:
    net.name  => net
  }
  name = each.value.name
  subnet4 = each.value.ipv4
  mask_length4 = each.value.masklen4
}

