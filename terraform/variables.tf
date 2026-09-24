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
    bound to. Verified against NSX Manager (Inventory > Containers > Clusters).
    Override if reapplying against a different cluster/environment.
  EOT
  type        = string
  default     = "3f9be0cf-c57f-4537-932c-84d9ddfd431f-prod01-9lqzy-vks01-antrea"
}

variable "antrea_coredns_cluster_id" {
  description = <<-EOT
    NSX Container Cluster ID for the Antrea/Kubernetes cluster the vks-coredns
    DFW policy is bound to. Currently the same cluster as antrea_cluster_id -
    kept as a separate variable in case they diverge later.
  EOT
  type        = string
  default     = "3f9be0cf-c57f-4537-932c-84d9ddfd431f-prod01-9lqzy-vks01-antrea"
}
