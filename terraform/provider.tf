terraform {
  required_version = ">= 1.5.0"

  required_providers {
    nsxt = {
      source = "vmware/nsxt"
      # nsxt_policy_parent_security_policy / nsxt_policy_security_policy_rule /
      # nsxt_policy_security_policy_container_cluster (antrea-policy) are Beta
      # resources added in 3.11.0.
    }
  }
}

provider "nsxt" {
  host                 = var.nsx_manager_host
  username             = var.nsx_username
  password             = var.nsx_password
  allow_unverified_ssl = var.allow_unverified_ssl
}
