# NOTE: The source DFW export only contains SecurityPolicy/Rule/ContainerCluster
# rows, not Group definitions - it references these groups by path only. The
# criteria below are BEST-EFFORT, inferred from the group names and how
# they're used in security_policy_lockdown.tf.
# Verify each one against the real group definitions in NSX Manager before apply -
# wrong criteria here means the policy binds to the wrong workloads.
#
# Only the groups scoping the two lockdown rules live here - the groups used
# by the ALLOW rules live alongside those rules in ../antrea-policy and
# ../database-policy.

# Whole "3tierapp" Kubernetes namespace - used as the ANTREA policy's default-deny scope.
resource "nsxt_policy_group" "tierapp_ns" {
  display_name = "3tierapp-ns"
  description  = "PLACEHOLDER criteria - verify against real NSX group. All members of the 3tierapp Kubernetes namespace."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Name"
      member_type = "Namespace"
      operator    = "EQUALS"
      value       = "3tierapp"
    }
  }
}

# VM-based database tier, matched by VM name.
resource "nsxt_policy_group" "tierapp_db" {
  display_name = "3tierapp-db"
  description  = "PLACEHOLDER criteria - verify against real NSX group. 3tierapp database VMs."

  criteria {
    condition {
      key         = "Name"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "3tierapp-db"
    }
  }
}
