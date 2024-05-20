#----------------------------------------------For EC2-SG---------------------------------------------#
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

#----------------------------------------------For EC2---------------------------------------------#
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id_1" {
  description = "Sub net ID-1"
  type        = string
}

variable "subnet_id_2" {
  description = "Sub net ID-2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "volume_size" {
  description = "EC2 Volume Size"
  type        = number
}

variable "volume_type" {
  description = "EC2 Volume Type"
  type        = string
}