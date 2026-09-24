# NOTE: The source DFW export only contains SecurityPolicy/Rule/ContainerCluster
# rows, not Group definitions - it references these groups by path only. The
# criteria below are BEST-EFFORT, inferred from the group names and how
# they're used in security_policy_tierapp.tf.
# Verify each one against the real group definitions in NSX Manager before apply -
# wrong criteria here means the policy binds to the wrong workloads.

# Frontend Kubernetes Service in the 3tierapp namespace. NSX requires a Service
# condition to always be paired with a Namespace condition in the same
# nested expression - a Service-only criteria is rejected.
resource "nsxt_policy_group" "tierapp_frontend_svc" {
  display_name = "3tierapp-frontend-svc"
  description  = "PLACEHOLDER criteria - verify against real NSX group. 3tierapp frontend Service in the 3tierapp namespace."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Name"
      member_type = "Namespace"
      operator    = "EQUALS"
      value       = "3tierapp"
    }
    condition {
      key         = "Name"
      member_type = "Service"
      operator    = "EQUALS"
      value       = "frontend-app-service"
    }
  }
}

# Backend Kubernetes Service in the 3tierapp namespace. See note above on
# tierapp_frontend_svc - Service criteria must include a Namespace condition.
resource "nsxt_policy_group" "tierapp_backend" {
  display_name = "3tierapp-backend"
  description  = "PLACEHOLDER criteria - verify against real NSX group. 3tierapp backend Service in the 3tierapp namespace."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Name"
      member_type = "Namespace"
      operator    = "EQUALS"
      value       = "3tierapp"
    }
    condition {
      key         = "Name"
      member_type = "Service"
      operator    = "EQUALS"
      value       = "backend-app-service"
    }
  }
}

# IP-based group for the 3tierapp database. group_type = "ANTREA" is required
# here even though this is a pure IP match - NSX rejects non-Antrea groups as
# rule members on a policy attached to an Antrea container cluster (error
# 610101).
resource "nsxt_policy_group" "tierapp_db_ip" {
  display_name = "3tierapp-db-ip"
  description  = "3tierapp database IP."
  group_type   = "ANTREA"

  criteria {
    ipaddress_expression {
      ip_addresses = ["172.16.30.100"]
    }
  }
}
