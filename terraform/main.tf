# Standalone vks-coredns DFW policy - own groups, own parent policy, own
# Antrea cluster attachment (a different cluster than baseline's). No
# dependency on the other modules; applied first.
module "antrea_coredns" {
  source = "./antrea_coredns"

  antrea_cluster_id = var.antrea_coredns_cluster_id
}

# Applied next: the ACNP and 3tierapp-db parent policies, the 3tierapp-ns/3tierapp-db
# groups, the Antrea cluster attachment, and the DROP/lockdown rules for
# both policies.
module "baseline" {
  source = "./baseline"

  antrea_cluster_id = var.antrea_cluster_id
}

# Amends the ACNP ALLOW rules onto the parent policy created above. Owns its
# own frontend/backend groups.
module "antrea_policy" {
  source = "./antrea_policy"

  policy_path = module.baseline.tierapp_policy_path
}

# Amends the database DFW ALLOW rule onto the parent policy created above.
# Owns its own egress group; the destination db group comes from baseline.
module "database_policy" {
  source = "./database_policy"

  policy_path   = module.baseline.tierapp_db_policy_path
  db_group_path = module.baseline.tierapp_db_group_path
}
