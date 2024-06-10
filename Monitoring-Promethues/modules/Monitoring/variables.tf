#------------------------Monitoring NameSpace-------------------------#
variable "name_space" {
  type = string
}

#------------------------Storage Class-------------------------#
variable "storage_class_name" {
  type = string
}

variable "storage_provisioner" {
  type = string
}

variable "storage_type" {
  type = string
}

#------------------------Helm-------------------------#
variable "helm_release_name" {
  type = string
}

variable "helm_repository" {
  type = string
}

variable "helm_chart" {
  type = string
}

variable "helm_chart_version" {
  type = string
}

variable "depends_of_monitoring" {
  type = string
}

