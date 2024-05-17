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
data "aws_vpc" "myvpc" {
  default = true
}

#Fetch Subnet's
# Subnet - 1
data "aws_subnet" "my_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["default-public"]
  }
}

# Subnet - 2
data "aws_subnet" "my_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["subnet2"]
  }
}

