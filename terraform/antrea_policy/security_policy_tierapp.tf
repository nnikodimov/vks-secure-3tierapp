# ACNP ALLOW rules for the 3tierapp cluster, amended onto the parent policy
# created in ../baseline (which also owns the lockdown DROP rule and the
# Antrea cluster attachment).
#
# Priority order below matches the export's ascending sequenceNumber (lower =
# higher priority, evaluated first): allow_tierapp_frontend (249999),
# allow_tierapp_frontend_to_backend (374999). The lockdown_tierapp_namespace DROP
# rule (499999) lives in ../baseline.

resource "nsxt_policy_security_policy_rule" "allow_tierapp_frontend" {
  display_name    = "allow_3tierapp_frontend"
  description     = "allow 3tierapp frontend"
  policy_path     = var.policy_path
  sequence_number = 1
  action          = "ALLOW"
  direction       = "IN"
  scope           = [nsxt_policy_group.tierapp_frontend_svc.path]

  service_entries {
    l4_port_set_entry {
      protocol          = "TCP"
      destination_ports = ["5000"]
    }
  }
}

resource "nsxt_policy_security_policy_rule" "allow_tierapp_frontend_to_backend" {
  display_name    = "allow_3tierapp_frontend_to_backend"
  description     = "allow 3tierapp frontend to backend"
  policy_path     = var.policy_path
  sequence_number = 2
  action          = "ALLOW"
  direction       = "IN_OUT"
  scope           = [nsxt_policy_group.tierapp_frontend_svc.path,nsxt_policy_group.tierapp_backend.path]

  service_entries {
    l4_port_set_entry {
      protocol          = "TCP"
      destination_ports = ["5000"]
    }
  }
}

resource "nsxt_policy_security_policy_rule" "allow_tierapp_backend_to_db_ip" {
  display_name       = "allow_3tierapp_backend_to_db_ip"
  description        = "allow 3tierapp backend to 3tierapp-db-ip"
  policy_path        = var.policy_path
  sequence_number    = 3
  action             = "ALLOW"
  direction          = "OUT"
  destination_groups = [nsxt_policy_group.tierapp_db_ip.path]
  services           = [data.nsxt_policy_service.mysql.path]
  scope              = [nsxt_policy_group.tierapp_backend.path]
}
