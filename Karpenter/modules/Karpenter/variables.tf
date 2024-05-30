#--------------------------------For Karpeneter---------------------------------------#
variable "karpenter_controller_arn" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "instace_profile" {
  type = string
}

variable "karpenter_depends_on" {
  type = string
}

