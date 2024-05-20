terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

module "VPC" {
  source = "./modules/VPC"

  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  public_rt_destination_cidr_block = var.public_rt_destination_cidr_block
  private_rt_destination_cidr_block = var.private_rt_destination_cidr_block
  security_group_name = var.vpc_security_group_name
  security_group_description = var.vpc_security_group_description
  security_group_ingress_cidr_blocks = var.security_group_ingress_cidr_blocks

}

module "Ec2" {
  source = "./modules/EC2"
  vpc_id = module.VPC.vpc_id
  subnet_id_1 = module.VPC.vpc_subnet_id_1
  subnet_id_2 = module.VPC.vpc_subnet_id_2
  security_group_name                = var.security_group_name
  security_group_description         = var.security_group_description
  security_group_ingress_cidr_blocks = var.security_group_ingress_cidr_blocks
  instance_type                      = var.instance_type
  volume_size                        = var.volume_size
  volume_type                        = var.volume_type
}

module "TG" {
  source = "./modules/TG"

  tg_name            = "Dhruv-TG"
  tg_port            = 80
  tg_protocol        = "HTTP"
  vpc_id = module.VPC.vpc_id
  tg_id              = module.Ec2.ec2_id
  tg_attachment_port = 80
  target_type        = var.target_type
  health_check       = var.health_check
}

module "LB" {
  source = "./modules/LB"

  lb_name                     = var.lb_name
  load_balancer_type          = var.load_balancer_type
  sg_id = [module.VPC.vpc_sg]
  subnets_id = [module.VPC.vpc_subnet_id_1, module.VPC.vpc_subnet_id_2]
  aws_lb_listener_port        = var.aws_lb_listener_port
  aws_lb_listener_protocol    = var.aws_lb_listener_protocol
  aws_lb_listener_action_type = var.aws_lb_listener_action_type
  target_group_arn            = module.TG.target_group_arn
}