#-------------For Trust relationship policy--------------#
#This variables used in data-source file
variable "openid_connect_provider_url" {
  type = string
}

variable "openid_connect_provider_arn" {
  type = string
}

#------------For Karpenter Controller Role------------------#
variable "karpenter_controller_name" {
  type = string
}

variable "karpenter_controller_policy_name" {
  type = string
}