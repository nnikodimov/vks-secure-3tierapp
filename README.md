# Secure VKS 3tierapp 

vDefend policies for the 3tierapp workload. The [terraform/](terraform/) folder
is the Terraform root module - it configures the single `nsxt` provider
instance ([terraform/provider.tf](terraform/provider.tf)) and calls three
child modules, split out so each can be reasoned about and applied
independently:

- [terraform/baseline/](terraform/baseline/) - creates the ACNP and 3tierapp-db
  parent policies, their groups, the Antrea cluster attachment, and locks
  both policies down with a default-deny DROP rule. Applied first.
- [terraform/antrea-policy/](terraform/antrea-policy/) - amends the ACNP
  ALLOW rules (frontend/backend pod-to-pod traffic) onto the parent policy
  created in `baseline`.
- [terraform/database-policy/](terraform/database-policy/) - amends the DFW
  ALLOW rule (egress to the database tier) onto the parent policy created in
  `baseline`.

`antrea-policy` and `database-policy` never create their own policies - they
attach rules to the policies from `baseline` via its outputs, which is what
makes `baseline` apply first. All three modules inherit the root's provider
configuration automatically - none declares its own `provider` block. Run
Terraform from the `terraform/` folder. To apply them one after another
against the shared state, target each module in turn:

```
cd terraform
terraform apply -target=module.baseline         # parent policies + lockdown rules first
terraform apply -target=module.antrea_policy    # then the ACNP allow rules
terraform apply                                  # then database_policy (and anything else pending)
```
