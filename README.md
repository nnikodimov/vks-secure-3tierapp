# Secure VKS 3tierapp 

vDefend policies for the 3tierapp workload. The [terraform/](terraform/) folder
is the Terraform root module - it configures the single `nsxt` provider
instance ([terraform/provider.tf](terraform/provider.tf)) and calls four
child modules, split out so each can be reasoned about and applied
independently:

- [terraform/antrea_coredns/](terraform/antrea_coredns/) - fully standalone:
  owns its own groups (`coredns`, `pod-cidr-block`, `dns-server`) and its own
  `vks-coredns` Infrastructure-category DFW policy, attached to a separate
  Antrea cluster (`var.antrea_coredns_cluster_id`). Doesn't depend on, or get
  depended on by, the other three modules. Applied first.
- [terraform/baseline/](terraform/baseline/) - creates the ACNP and 3tierapp-db
  parent policies, their groups, the Antrea cluster attachment, and locks
  both policies down with a default-deny DROP rule. Applied next.
- [terraform/antrea_policy/](terraform/antrea_policy/) - amends the ACNP
  ALLOW rules (frontend/backend pod-to-pod traffic, and backend-to-db-ip MySQL
  traffic) onto the parent policy created in `baseline`.
- [terraform/database_policy/](terraform/database_policy/) - amends the DFW
  ALLOW rule (egress to the database tier) onto the parent policy created in
  `baseline`.

`antrea_policy` and `database_policy` never create their own policies - they
attach rules to the policies from `baseline` via its outputs, which is what
makes `baseline` apply before them. All four modules inherit the root's
provider configuration automatically - none declares its own `provider`
block, so none of them can be `init`/`apply`'d from inside its own folder;
always run Terraform from the `terraform/` folder. To apply them one after
another against the shared state, target each module in turn:

```
cd terraform
terraform apply -target=module.antrea_coredns   # independent - applied first
terraform apply -target=module.baseline         # parent policies + lockdown rules next
terraform apply -target=module.antrea_policy    # then the ACNP allow rules
terraform apply                                  # then database_policy (and anything else pending)
```
