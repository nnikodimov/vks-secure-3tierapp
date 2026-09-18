# DFW ALLOW rule for the 3tierapp database tier, amended onto the parent policy
# created in ../baseline (which also owns the lockdown DROP rule).
#
# Priority order matches the export's ascending sequenceNumber: this allow
# rule (499999) is evaluated before the lockdown_database default-deny
# (749999) in ../baseline.

resource "nsxt_policy_security_policy_rule" "allow_tierapp_egress_to_database" {
  display_name       = "allow_3tierapp_egress_to_database"
  description        = "allow 3tierapp egress to database"
  policy_path        = var.policy_path
  sequence_number    = 1
  action             = "ALLOW"
  direction          = "IN"
  source_groups      = [nsxt_policy_group.tierapp_egress.path]
  destination_groups = [var.db_group_path]
  services           = [data.nsxt_policy_service.mysql.path]
  scope              = [var.db_group_path]
}
