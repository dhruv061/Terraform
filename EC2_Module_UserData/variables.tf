#----------------------------------------------For Provider---------------------------------------------#
variable "aws_profile" {
  description = "AWS profile to use"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

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

#-------------------------------------------------For IAM Role----------------------------------------#
variable "iam_role_name" {
  description = "Name for the IAM Role"
  type        = string
}