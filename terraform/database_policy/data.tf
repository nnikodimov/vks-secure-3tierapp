# MySQL is a built-in NSX system service (like the default DFW sections we
# intentionally don't manage here) - looked up rather than recreated.
data "nsxt_policy_service" "mysql" {
  display_name = "MySQL"
}
