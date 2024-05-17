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

#----------------------------------------------For TG creation---------------------------------------------#
variable "tg_name" {
  description = "Name of Target Group"
  type        = string
}

variable "tg_port" {
  description = "Send trffic to this port"
  type        = number
}

variable "tg_protocol" {
  description = "Protocol for Target Group"
  type        = string
}

#----------------------------------------------For TG Attachment---------------------------------------------#
variable "tg_attachment_port" {
  description = "Port of Target Group Attachment"
  type        = number
}

variable "target_type" {
  description = "Target Type"
  type        = string
}

variable "health_check" {
  type = map(string)
}

#--------------------------------------For LB-----------------------------------------#
variable "lb_name" {
  description = "Load Balanacer Name"
  type        = string
}

variable "load_balancer_type" {
  description = "Type of LB"
  type        = string
}

#--------------------------------------For LB Listener-----------------------------------------#
variable "aws_lb_listener_port" {
  description = "Port of LB listener"
  type        = number
}

variable "aws_lb_listener_protocol" {
  description = "Protocol of LB listener"
  type        = string
}

variable "aws_lb_listener_action_type" {
  description = "Action for LB listener"
  type        = string
}

