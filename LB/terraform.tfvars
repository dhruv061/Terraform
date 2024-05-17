#----------------------------------------------For Provider---------------------------------------------#
aws_profile = "default"
aws_region  = "ap-south-1"

#----------------------------------------------For EC2-SG---------------------------------------------#
security_group_name                = "Dhruv-EC2-SG"
security_group_description         = "Sg for EC2"
security_group_ingress_cidr_blocks = ["0.0.0.0/0"]

#----------------------------------------------For EC2---------------------------------------------#
instance_type = "t2.micro"
volume_size   = 20
volume_type   = "gp3"
#----------------------------------------------For TG creation---------------------------------------------#
tg_name     = "Dhruv-TG"
tg_port     = 80
tg_protocol = "HTTP"
#----------------------------------------------For TG Attachment---------------------------------------------#
tg_attachment_port = 80
target_type        = "instance"
health_check = {
  "timeout"             = "10"
  "interval"            = "20"
  "path"                = "/"
  "port"                = "80"
  "unhealthy_threshold" = "2"
  "healthy_threshold"   = "3"
}
#----------------------------------------------For LB---------------------------------------------#
lb_name            = "Dhruv-ALB"
load_balancer_type = "application"
#----------------------------------------------For LB Listener-------------------------------------#
aws_lb_listener_port        = 80
aws_lb_listener_protocol    = "HTTP"
aws_lb_listener_action_type = "forward"