#---------------------------------------------FOR Node Group-----------------------------------------------------#
variable "cluster_name" {
  description = "EKS Cluster Name"
  type = string
}

variable "node_group_name" {
  description = "EKS Cluster NG Name"
  type = string
}

variable "eks_node_grp_role_Arn" {
  type = string
}

variable "subnet_ids" {
  type    = list(string)
}

variable "capacity_type" {
  description = "Type of capacity"
  type = string
}

variable "disk_size" {
  description = "Size of the disk"
  type = number
}

variable "instance_types" {
  description = "List of instance types"
  type        = list(string)
}

variable "scaling_config" {
  description = "Scaling configuration"
  type        = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
}

variable "update_config" {
  description = "Update configuration"
  type        = object({
    max_unavailable = number
  })
}

variable "ng_depends_on" {
  type = list(string)
}
