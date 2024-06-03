#----------------------------------------------For VPC----------------------------------------------------#
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR block for the public subnet"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR block for the private subnet"
  type        = list(string)
}

variable "public_rt_destination_cidr_block" {
  description = "Destination CIDR block for public route table"
  type        = string
}

variable "private_rt_destination_cidr_block" {
  description = "Destination CIDR block for private route table"
  type        = string
}

#----------------------------------------------For VPC-SG---------------------------------------------#
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