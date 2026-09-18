output "allow_tierapp_egress_to_database_path" {
  description = "NSX policy path of the allow_tierapp_egress_to_database rule"
  value       = nsxt_policy_security_policy_rule.allow_tierapp_egress_to_database.path
}
