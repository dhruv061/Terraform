terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

module "IAM" {
  source = "./modules/IAM"

  iam_role_name = var.iam_role_name
}

module "Ec2" {
  source = "./modules/EC2"

  security_group_name                = var.security_group_name
  security_group_description         = var.security_group_description
  security_group_ingress_cidr_blocks = var.security_group_ingress_cidr_blocks
  instance_type                      = var.instance_type
  volume_size                        = var.volume_size
  volume_type                        = var.volume_type
  instance_profile                   = module.IAM.iam_instace_profile
}

