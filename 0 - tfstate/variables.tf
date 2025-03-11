 variable "cp_addresses" {
   type = list(string)
   default = ["77.33.182.50/32", "109.148.15.64/32"]
}
  variable "fdb_addresses" {
   type = list(string)
   default = ["239.255.255.255/32"]
}