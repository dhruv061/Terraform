#------------------------------------------FOR EKS IAM ROLE-----------------------------------------------#
variable "eks_cluster_role_name" {
  description = "EKS Cluster Role Name"
  type = string
}

variable "eks_node_group_name" {
  description = "EKS Node Group Role Name"
  type = string
}

