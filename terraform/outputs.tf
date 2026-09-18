output "tierapp_policy_path" {
  description = "NSX policy path of the 3tierapp ACNP (Antrea) security policy"
  value       = module.baseline.tierapp_policy_path
}

output "tierapp_container_cluster_span_path" {
  description = "NSX policy path of the 3tierapp_policy <-> Antrea cluster association"
  value       = module.baseline.tierapp_container_cluster_span_path
}

output "tierapp_db_policy_path" {
  description = "NSX policy path of the 3tierapp-db DFW security policy"
  value       = module.baseline.tierapp_db_policy_path
}

output "lockdown_tierapp_namespace_path" {
  description = "NSX policy path of the 3tierapp ACNP namespace lockdown rule"
  value       = module.baseline.lockdown_tierapp_namespace_path
}

output "lockdown_database_path" {
  description = "NSX policy path of the 3tierapp-db lockdown rule"
  value       = module.baseline.lockdown_database_path
}

output "allow_tierapp_frontend_path" {
  description = "NSX policy path of the allow_tierapp_frontend rule"
  value       = module.antrea_policy.allow_tierapp_frontend_path
}

output "allow_tierapp_frontend_to_backend_path" {
  description = "NSX policy path of the allow_tierapp_frontend_to_backend rule"
  value       = module.antrea_policy.allow_tierapp_frontend_to_backend_path
}

output "allow_tierapp_egress_to_database_path" {
  description = "NSX policy path of the allow_tierapp_egress_to_database rule"
  value       = module.database_policy.allow_tierapp_egress_to_database_path
}
