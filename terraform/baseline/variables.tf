variable "antrea_cluster_id" {
  description = <<-EOT
    NSX Container Cluster ID for the Antrea/Kubernetes cluster the 3tierapp ACNP is
    bound to. Defaults to the ID parsed out of the source export's
    containerClusterPath (.../cluster-control-planes/<id>). Override if reapplying
    against a different cluster/environment.
  EOT
  type        = string
  default     = "3f9be0cf-c57f-4537-932c-84d9ddfd431f-prod01-9lqzy-vks01-antrea"
}
