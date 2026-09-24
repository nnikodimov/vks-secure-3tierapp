# MySQL is a built-in NSX system service - looked up rather than recreated.
data "nsxt_policy_service" "mysql" {
  display_name = "MySQL"
}
