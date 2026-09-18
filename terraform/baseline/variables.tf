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
