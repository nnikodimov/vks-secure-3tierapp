variable "nsx_manager_host" {
  description = "NSX Manager / vDefend hostname or IP, e.g. nsx-manager.example.com"
  type        = string
}

variable "nsx_username" {
  description = "NSX Manager username"
  type        = string
}

variable "nsx_password" {
  description = "NSX Manager password"
  type        = string
  sensitive   = true
}

variable "allow_unverified_ssl" {
  description = "Skip TLS certificate verification against NSX Manager (set false and trust the cert in production)"
  type        = bool
  default     = false
}

variable "antrea_cluster_id" {
  description = <<-EOT
    NSX Container Cluster ID for the Antrea/Kubernetes cluster the 3tierapp ACNP is
    bound to. Defaults to the ID parsed out of the source export's
    containerClusterPath (.../cluster-control-planes/<id>). Override if reapplying
    against a different cluster/environment.
  EOT
  type        = string
  default     = "7dba6c18-766a-4c69-b084-04f1fb81bd94-prod01-y9x87-vks01-antrea"
}
