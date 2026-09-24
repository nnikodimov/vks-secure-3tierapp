variable "policy_path" {
  description = "NSX policy path of the 3tierapp-db parent security policy (from ../baseline)"
  type        = string
}

variable "db_group_path" {
  description = "NSX policy path of the 3tierapp database VM group (from ../baseline)"
  type        = string
}
