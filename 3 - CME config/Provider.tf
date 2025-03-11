# https://registry.terraform.io/providers/checkpointsw/checkpoint/latest/docs

terraform {
  required_providers {
    checkpoint = {
      source = "CheckPointSW/checkpoint"
      version = "2.9.0"
    }
  }
}

# Configure Check Point Provider for Management API
provider "checkpoint" {
  server = var.server
  context = "web_api"
  session_name = "Terraform session"
  cloud_mgmt_id = var.cloud_mgmt_id
  api_key = var.QSM_API_KEY
  auto_publish_batch_size = 1
}
