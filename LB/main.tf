terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

module "Ec2" {
  source = "./modules/EC2"

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
  vpc_id = module.Ec2.vpc_id
  tg_id              = module.Ec2.ec2_id
  tg_attachment_port = 80
  target_type        = var.target_type
  health_check       = var.health_check
}

module "LB" {
  source = "./modules/LB"

  lb_name                     = var.lb_name
  load_balancer_type          = var.load_balancer_type
  subnets_id = [module.Ec2.subnet_1_id, module.Ec2.subnet_2_id]
  aws_lb_listener_port        = var.aws_lb_listener_port
  aws_lb_listener_protocol    = var.aws_lb_listener_protocol
  aws_lb_listener_action_type = var.aws_lb_listener_action_type
  target_group_arn            = module.TG.target_group_arn
}