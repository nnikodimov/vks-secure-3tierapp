# The Antrea/Kubernetes cluster the vks-coredns DFW policy is bound to.
data "nsxt_policy_container_cluster" "vks" {
  id = var.antrea_cluster_id
}

# Built-in NSX default services - looked up rather than recreated.
data "nsxt_policy_service" "dns_tcp" {
  display_name = "DNS-TCP"
}

data "nsxt_policy_service" "dns_udp" {
  display_name = "DNS-UDP"
}
