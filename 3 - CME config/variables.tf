variable "server" {
  type = string
  default = "dsv-poc-6vp4hm62.maas.checkpoint.com"
}
variable "QSM_API_KEY" {
  type = string
  sensitive = true
}
variable "cloud_mgmt_id" {
  type = string
  default = "0bf4b4cf-1605-47c7-9d1c-6b8a4812ff94"
}
variable "management_name" {
  type = string
  default = "mnFDB"
}
variable "account_details" {
  type = object({
    name = string
    directory_id = string
    application_id = string
    subscription = string
    client_secret = string
    environment = string
  })
  sensitive = true
}
variable "R81_20_template_details" {
  type = object({
    name = string
    related_account = string
    version = string
    sic_key = string
    policy = string
    send_logs_to_server = optional (list (string) )
    send_logs_to_backup_server = optional (list(string))
    send_alerts_to_server = optional (list(string))
    section_name = optional (string)
    x_forwarded_for = optional (bool)
    color = optional (string)
    ipv6 = optional (bool)
    communication_with_servers_behind_nat = optional (string)
    blades = object({
        ips                          = bool
        anti_bot                     = bool
        anti_virus                   = bool
        https_inspection             = bool
        application_control          = bool
        autonomous_threat_prevention = bool
        content_awareness            = bool
        identity_awareness           = bool
        ipsec_vpn                    = bool
        threat_emulation             = bool
        url_filtering                = bool
        vpn                          = bool
    })
    identity_awareness_settings = optional (object ({
        enable_cloudguard_controller = bool
        receive_identities_from = optional (list (string))
    }))

  })
}
variable "repository_gateway_script" {
       type = object({
        name = string
        script_file = string
    })
}
variable "cp_hosts" {
  type = list(object({
    name = string
    ipv4 = string
  }))
}
variable "cp_nets" {
  type = list(object({
    name = string
    ipv4 = string
    masklen4 = number
  }))
}