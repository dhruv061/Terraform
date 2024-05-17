#Fecth AMI ID
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#Fetch VPC 
data "aws_vpc" "selected" {
  default = true
}

#Fetch SubnetID
data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["default-public"]
  }
}

