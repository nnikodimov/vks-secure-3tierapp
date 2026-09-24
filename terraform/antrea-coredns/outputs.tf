output "coredns_group_path" {
  description = "NSX policy path of the coredns group"
  value       = nsxt_policy_group.coredns.path
}

output "pod_cidr_block_group_path" {
  description = "NSX policy path of the pod-cidr-block group"
  value       = nsxt_policy_group.pod_cidr_block.path
}

output "dns_server_group_path" {
  description = "NSX policy path of the dns-server group"
  value       = nsxt_policy_group.dns_server.path
}

output "vks_coredns_policy_path" {
  description = "NSX policy path of the vks-coredns DFW parent security policy"
  value       = nsxt_policy_parent_security_policy.vks_coredns.path
}

output "vks_coredns_container_cluster_span_path" {
  description = "NSX policy path of the vks-coredns <-> Antrea cluster association"
  value       = nsxt_policy_security_policy_container_cluster.vks_coredns.path
}

output "allow_any_to_coredns_dns_path" {
  description = "NSX policy path of the allow_any_to_coredns_dns rule"
  value       = nsxt_policy_security_policy_rule.allow_any_to_coredns_dns.path
}

output "allow_pod_cidr_block_to_coredns_dns_path" {
  description = "NSX policy path of the allow_pod_cidr_block_to_coredns_dns rule"
  value       = nsxt_policy_security_policy_rule.allow_pod_cidr_block_to_coredns_dns.path
}

output "allow_coredns_to_dns_server_path" {
  description = "NSX policy path of the allow_coredns_to_dns_server rule"
  value       = nsxt_policy_security_policy_rule.allow_coredns_to_dns_server.path
}

output "drop_coredns_dns_path" {
  description = "NSX policy path of the drop_coredns_dns rule"
  value       = nsxt_policy_security_policy_rule.drop_coredns_dns.path
}
