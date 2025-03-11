resource "checkpoint_management_cme_management" "this" {
  name = var.management_name
}

resource "checkpoint_management_repository_script" "this" {
  name = var.repository_gateway_script.name
  script_body = file(var.repository_gateway_script.script_file)
}

resource "checkpoint_management_cme_accounts_azure" "this" {
  name           = var.account_details.name
  directory_id   = var.account_details.directory_id
  application_id = var.account_details.application_id
  client_secret  = var.account_details.client_secret
  subscription   = var.account_details.subscription
  environment    = var.account_details.environment
}

resource "checkpoint_management_cme_gw_configurations_azure" "gw_config_azure" {
  depends_on = [ checkpoint_management_repository_script.this ]
  name                       = var.R81_20_template_details.name
  related_account            = var.R81_20_template_details.related_account
  version                    =  var.R81_20_template_details.version
  base64_sic_key             = base64encode(var.R81_20_template_details.sic_key)
  policy                     = var.R81_20_template_details.policy
#  send_logs_to_server        = var.R81_20_template_details.send_logs_to_server
#  send_logs_to_backup_server = var.R81_20_template_details.send_logs_to_backup_server
#  send_alerts_to_server      = var.R81_20_template_details.send_alerts_to_server
#  section_name               = "my_section"
#  x_forwarded_for            = true
  color                      = var.R81_20_template_details.color
#  ipv6                       = true
#  communication_with_servers_behind_nat = "translated-ip-only"

  repository_gateway_scripts {
    name       = checkpoint_management_repository_script.this.name
    parameters = ""
  }
  blades {
    ips                          = var.R81_20_template_details.blades.ips
    anti_bot                     = var.R81_20_template_details.blades.anti_bot
    anti_virus                   = var.R81_20_template_details.blades.anti_virus
    https_inspection             = var.R81_20_template_details.blades.https_inspection
    application_control          = var.R81_20_template_details.blades.application_control
    autonomous_threat_prevention = var.R81_20_template_details.blades.autonomous_threat_prevention
    content_awareness            = var.R81_20_template_details.blades.content_awareness
    identity_awareness           = var.R81_20_template_details.blades.identity_awareness
    ipsec_vpn                    = var.R81_20_template_details.blades.ipsec_vpn
    threat_emulation             = var.R81_20_template_details.blades.threat_emulation
    url_filtering                = var.R81_20_template_details.blades.url_filtering
    vpn                          = var.R81_20_template_details.blades.vpn
  }
  identity_awareness_settings {
    enable_cloudguard_controller = var.R81_20_template_details.identity_awareness_settings.enable_cloudguard_controller
#     receive_identities_from      = var.R81_20_template_details.identity_awareness_settings.receive_identities_from
  }
}