terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

#------------------------------------VPC------------------------------------------------#
module "VPC" {
  source = "./modules/VPC"

  vpc_cidr                           = var.vpc_cidr
  public_subnet_cidrs                = var.public_subnet_cidrs
  private_subnet_cidrs               = var.private_subnet_cidrs
  public_rt_destination_cidr_block   = var.public_rt_destination_cidr_block
  private_rt_destination_cidr_block  = var.private_rt_destination_cidr_block
  security_group_name                = var.vpc_security_group_name
  security_group_description         = var.vpc_security_group_description
  security_group_ingress_cidr_blocks = var.security_group_ingress_cidr_blocks

}

#------------------------------------EC2------------------------------------------------#
module "Ec2" {
  source = "./modules/EC2"

  vpc_id                             = module.VPC.vpc_id
  subnet_id_1                        = module.VPC.vpc_subnet_id_1
  subnet_id_2                        = module.VPC.vpc_subnet_id_2
  key_name = var.key_name
  security_group_name                = var.security_group_name
  security_group_description         = var.security_group_description
  security_group_ingress_cidr_blocks = var.security_group_ingress_cidr_blocks
  instance_type                      = var.instance_type
  volume_size                        = var.volume_size
  volume_type                        = var.volume_type
  ami_name                           = var.ami_name
}

#------------------------------------TG------------------------------------------------#
module "TG" {
  source = "./modules/TG"

  tg_name            = "Dhruv-TG"
  tg_port            = 80
  tg_protocol        = "HTTP"
  vpc_id             = module.VPC.vpc_id
  tg_id              = module.Ec2.ec2_id
  tg_attachment_port = 80
  target_type        = var.target_type
  health_check       = var.health_check
}

#------------------------------------LB------------------------------------------------#
module "LB" {
  source = "./modules/LB"

  lb_name                     = var.lb_name
  load_balancer_type          = var.load_balancer_type
  sg_id                       = [module.VPC.vpc_sg]
  subnets_id                  = [module.VPC.vpc_subnet_id_1, module.VPC.vpc_subnet_id_2]
  aws_lb_listener_port        = var.aws_lb_listener_port
  aws_lb_listener_protocol    = var.aws_lb_listener_protocol
  aws_lb_listener_action_type = var.aws_lb_listener_action_type
  target_group_arn            = module.TG.target_group_arn
}

#------------------------------------ASG------------------------------------------------#
module "ASG" {
  source = "./modules/ASG"

  lt_name                           = var.lt_name
  lt_ami_img                        = module.Ec2.ami_id
  lt_instance_type                  = var.lt_instance_type
  asg_name                          = var.asg_name
  asg_availability_zones            = var.asg_availability_zones
  asg_desired_capacity              = var.asg_desired_capacity
  asg_max_size                      = var.asg_max_size
  asg_min_size                      = var.asg_min_size
  asg_vpc_zone_identifier           = [module.VPC.vpc_subnet_id_1, module.VPC.vpc_subnet_id_2]
  asg_health_check_type             = var.asg_health_check_type
  asg_termination_policies          = var.asg_termination_policies
  default_cooldown                  = var.default_cooldown
  target_group_arns                 = [module.TG.target_group_arn]
  asg_policy_name                   = var.asg_policy_name
  asg_policy_type                   = var.asg_policy_type
  asg_policy_target_value           = var.asg_policy_target_value
  asg_policy_predefined_metric_type = var.asg_policy_predefined_metric_type
}