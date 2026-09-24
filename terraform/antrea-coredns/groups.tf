# CoreDNS Pods, matched by the Kubernetes-projected NSX tag scope:tag pair
# k8s-app=kube-dns (tag condition value is "scope|tag" per the nsxt provider).
# Verify the "dis:k8s:k8s-app" scope string against the real tag on the
# kube-dns Pods in NSX Manager before apply - it's expected to vary per
# cluster/environment.
resource "nsxt_policy_group" "coredns" {
  display_name = "coredns"
  description  = "CoreDNS Pods (k8s-app=kube-dns)."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Tag"
      member_type = "Pod"
      operator    = "EQUALS"
      value       = "dis:k8s:k8s-app|kube-dns"
    }
  }
}

# IP-based group covering the cluster's Pod CIDR block.
resource "nsxt_policy_group" "pod_cidr_block" {
  display_name = "pod-cidr-block"
  description  = "Cluster Pod CIDR block."

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.95.0.0/16"]
    }
  }
}

# IP-based group for the upstream DNS server the cluster forwards to.
resource "nsxt_policy_group" "dns_server" {
  display_name = "dns-server"
  description  = "Upstream DNS server."

  criteria {
    ipaddress_expression {
      ip_addresses = ["192.168.110.10"]
    }
  }
}
