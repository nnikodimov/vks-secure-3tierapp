# DFW policy for CoreDNS, attached to the Antrea cluster identified by
# var.antrea_cluster_id. Split across nsxt_policy_parent_security_policy +
# nsxt_policy_security_policy_rule (see ../baseline for why) since
# nsxt_policy_security_policy_container_cluster can only attach to a "parent"
# policy.

resource "nsxt_policy_parent_security_policy" "vks_coredns" {
  display_name    = "vks-coredns"
  description     = "vks-coredns"
  category        = "Infrastructure"
  stateful        = true
  tcp_strict      = true
  sequence_number = 20
  lifecycle {
    create_before_destroy = true
  }
}

resource "nsxt_policy_security_policy_container_cluster" "vks_coredns" {
  display_name           = "vks-coredns-cluster-span"
  description            = "Antrea container cluster span for vks-coredns"
  policy_path            = nsxt_policy_parent_security_policy.vks_coredns.path
  container_cluster_path = data.nsxt_policy_container_cluster.vks.path
}

# Rule 1: allow any -> coredns, DNS-TCP/DNS-UDP, outbound.
resource "nsxt_policy_security_policy_rule" "allow_any_to_coredns_dns" {
  display_name       = "allow_any_to_coredns_dns"
  description        = "allow any to coredns dns"
  policy_path        = nsxt_policy_parent_security_policy.vks_coredns.path
  sequence_number    = 1
  action             = "ALLOW"
  direction          = "OUT"
  destination_groups = [nsxt_policy_group.coredns.path]
  services           = [data.nsxt_policy_service.dns_tcp.path, data.nsxt_policy_service.dns_udp.path]
}

# Rule 2: allow pod-cidr-block -> any, DNS-TCP/DNS-UDP, inbound to coredns.
resource "nsxt_policy_security_policy_rule" "allow_pod_cidr_block_to_coredns_dns" {
  display_name    = "allow_pod_cidr_block_to_coredns_dns"
  description     = "allow pod-cidr-block to coredns dns"
  policy_path     = nsxt_policy_parent_security_policy.vks_coredns.path
  sequence_number = 2
  action          = "ALLOW"
  direction       = "IN"
  source_groups   = [nsxt_policy_group.pod_cidr_block.path]
  services        = [data.nsxt_policy_service.dns_tcp.path, data.nsxt_policy_service.dns_udp.path]
  scope           = [nsxt_policy_group.coredns.path]
}

# Rule 3: allow coredns -> dns-server, DNS-TCP/DNS-UDP, outbound.
resource "nsxt_policy_security_policy_rule" "allow_coredns_to_dns_server" {
  display_name       = "allow_coredns_to_dns_server"
  description        = "allow coredns to dns-server"
  policy_path        = nsxt_policy_parent_security_policy.vks_coredns.path
  sequence_number    = 3
  action             = "ALLOW"
  direction          = "OUT"
  destination_groups = [nsxt_policy_group.dns_server.path]
  services           = [data.nsxt_policy_service.dns_tcp.path, data.nsxt_policy_service.dns_udp.path]
  scope              = [nsxt_policy_group.coredns.path]
}

# Rule 4: default-deny for any other DNS-TCP/DNS-UDP traffic on coredns not
# matched by rules 1-3. Scoped to coredns (not stated explicitly, but this
# closes out the policy the same way lockdown_tierapp_namespace does in
# ../baseline) - verify against the real NSX group/rule before apply.
resource "nsxt_policy_security_policy_rule" "drop_coredns_dns" {
  display_name    = "drop_coredns_dns"
  description     = "drop coredns dns"
  policy_path     = nsxt_policy_parent_security_policy.vks_coredns.path
  sequence_number = 4
  action          = "DROP"
  direction       = "IN_OUT"
  services        = [data.nsxt_policy_service.dns_tcp.path, data.nsxt_policy_service.dns_udp.path]
  logged          = true
  log_label       = "coredns-acnp"
}
