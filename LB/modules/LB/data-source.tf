#Fetch VPC SG
data "aws_security_group" "aws_sg_vpc" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

