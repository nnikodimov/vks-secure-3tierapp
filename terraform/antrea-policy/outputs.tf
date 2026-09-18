output "allow_tierapp_frontend_path" {
  description = "NSX policy path of the allow_tierapp_frontend rule"
  value       = nsxt_policy_security_policy_rule.allow_tierapp_frontend.path
}

output "allow_tierapp_frontend_to_backend_path" {
  description = "NSX policy path of the allow_tierapp_frontend_to_backend rule"
  value       = nsxt_policy_security_policy_rule.allow_tierapp_frontend_to_backend.path
}
