output "tierapp_policy_path" {
  description = "NSX policy path of the 3tierapp ACNP (Antrea) parent security policy"
  value       = nsxt_policy_parent_security_policy.tierapp.path
}

output "tierapp_container_cluster_span_path" {
  description = "NSX policy path of the 3tierapp_policy <-> Antrea cluster association"
  value       = nsxt_policy_security_policy_container_cluster.tierapp.path
}

output "tierapp_db_policy_path" {
  description = "NSX policy path of the 3tierapp-db DFW parent security policy"
  value       = nsxt_policy_parent_security_policy.tierapp_db.path
}

output "tierapp_db_group_path" {
  description = "NSX policy path of the 3tierapp database VM group"
  value       = nsxt_policy_group.tierapp_db.path
}

output "lockdown_tierapp_namespace_path" {
  description = "NSX policy path of the 3tierapp ACNP namespace lockdown rule"
  value       = nsxt_policy_security_policy_rule.lockdown_tierapp_namespace.path
}

output "lockdown_database_path" {
  description = "NSX policy path of the 3tierapp-db lockdown rule"
  value       = nsxt_policy_security_policy_rule.lockdown_database.path
}
