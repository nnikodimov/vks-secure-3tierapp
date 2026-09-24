output "allow_tierapp_frontend_path" {
  description = "NSX policy path of the allow_tierapp_frontend rule"
  value       = nsxt_policy_security_policy_rule.allow_tierapp_frontend.path
}

output "allow_tierapp_frontend_to_backend_path" {
  description = "NSX policy path of the allow_tierapp_frontend_to_backend rule"
  value       = nsxt_policy_security_policy_rule.allow_tierapp_frontend_to_backend.path
}

output "tierapp_db_ip_group_path" {
  description = "NSX policy path of the 3tierapp-db-ip group"
  value       = nsxt_policy_group.tierapp_db_ip.path
}

output "allow_tierapp_backend_to_db_ip_path" {
  description = "NSX policy path of the allow_tierapp_backend_to_db_ip rule"
  value       = nsxt_policy_security_policy_rule.allow_tierapp_backend_to_db_ip.path
}
