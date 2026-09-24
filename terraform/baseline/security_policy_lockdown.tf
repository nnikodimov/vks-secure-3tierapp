# Baseline: creates the ACNP and 3tierapp-db parent policies (plus their groups
# and, for the ACNP, its Antrea cluster attachment), and locks both down with
# a default-deny DROP rule. ../antrea_policy and ../database_policy are
# applied afterwards, amending their ALLOW rules onto these same policies via
# policy_path - they never create the policies themselves.
#
# Split across nsxt_policy_parent_security_policy + nsxt_policy_security_policy_rule
# because nsxt_policy_security_policy_container_cluster can only attach to a
# "parent" policy, not the combined nsxt_policy_security_policy resource, and
# because the ALLOW rules amended in from the other two modules need an
# independent policy_path to attach to.

resource "nsxt_policy_parent_security_policy" "tierapp" {
  display_name    = "3tierapp_vks_policy"
  description     = "3tierapp_vks_policy"
  category        = "Application"
  stateful        = true
  tcp_strict      = true
  sequence_number = 10
  lifecycle {
    create_before_destroy = true
  }
}

resource "nsxt_policy_security_policy_container_cluster" "tierapp" {
  display_name           = "3tierapp-cluster-span"
  description            = "Antrea container cluster span for 3tierapp_policy"
  policy_path            = nsxt_policy_parent_security_policy.tierapp.path
  container_cluster_path = data.nsxt_policy_container_cluster.tierapp.path
}

# Priority order matches the export's ascending sequenceNumber: this DROP
# rule (499999) is the last ACNP rule - allow_tierapp_frontend (249999) and
# allow_tierapp_frontend_to_backend (374999) in ../antrea_policy are evaluated
# first.

resource "nsxt_policy_security_policy_rule" "lockdown_tierapp_namespace" {
  display_name    = "lockdown_3tierapp_namespace"
  description     = "lockdown 3tierapp namespace"
  policy_path     = nsxt_policy_parent_security_policy.tierapp.path
  sequence_number = 666
  action          = "DROP"
  direction       = "IN_OUT"
  scope           = [nsxt_policy_group.tierapp_ns.path]
  logged          = true
  log_label       = "3tierapp-acnp"
}

resource "nsxt_policy_parent_security_policy" "tierapp_db" {
  display_name    = "3tierapp_db_policy"
  description     = "3tierapp_db policy"
  category        = "Application"
  stateful        = true
  tcp_strict      = true
  sequence_number = 20
  lifecycle {
    create_before_destroy = true
  }
}

# Priority order matches the export's ascending sequenceNumber: this DROP
# rule (749999) comes after allow_tierapp_egress_to_database (499999) in
# ../database_policy.

resource "nsxt_policy_security_policy_rule" "lockdown_database" {
  display_name    = "lockdown_database"
  description     = "lockdown database"
  policy_path     = nsxt_policy_parent_security_policy.tierapp_db.path
  scope           = [nsxt_policy_group.tierapp_db.path]
  sequence_number = 666
  action          = "DROP"
  direction       = "IN"
  logged          = true
  log_label       = "3tierapp-db"
}
