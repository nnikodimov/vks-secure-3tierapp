# NOTE: The source DFW export only contains SecurityPolicy/Rule/ContainerCluster
# rows, not Group definitions - it references these groups by path only. The
# criteria below are BEST-EFFORT, inferred from the group names and how
# they're used in security_policy_tierapp_db.tf.
# Verify each one against the real group definitions in NSX Manager before apply -
# wrong criteria here means the policy binds to the wrong workloads.

# Antrea Egress object used as the SNAT identity when 3tierapp pods leave the
# cluster to reach the VM-based database tier. AntreaEgress is not part of
# the ANTREA group_type's supported member types ([Namespace, IPAddress,
# Service, Pod]), so this must be a generic group (no group_type set).
resource "nsxt_policy_group" "tierapp_egress" {
  display_name = "3tierapp-egress"
  description  = "PLACEHOLDER criteria - verify against real NSX group. 3tierapp Antrea Egress."

  criteria {
    condition {
      key         = "Name"
      member_type = "AntreaEgress"
      operator    = "EQUALS"
      value       = "3tierapp-egress"
    }
  }
}
