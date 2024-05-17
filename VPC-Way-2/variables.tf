#----------------------------------------------For Provider---------------------------------------------#
variable "aws_profile" {
  description = "AWS profile to use"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

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