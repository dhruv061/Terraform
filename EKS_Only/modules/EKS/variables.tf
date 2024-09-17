#---------------------------------------------FOR EKS-----------------------------------------------------#
variable "cluster_name" {
  description = "EKS Cluster Name"
  type = string
}

variable "subnet_ids" {
  type    = list(string)
}

variable "eks_Cluster_role_Arn" {
  type = string
}

variable "eks_depends_on" {
  type = list(string)
}

#----------------------------------------------For EKS-SG---------------------------------------------#
variable "vpc_id" {
  description = "Name for the security group"
  type        = string
}

variable "security_group_name" {
  description = "Name for the security group"
  type        = string
}

variable "security_group_description" {
  description = "Description for the security group"
  type        = string
}

variable "security_group_ingress_cidr_blocks" {
  description = "CIDR blocks for security group ingress rules"
  type        = list(string)
}