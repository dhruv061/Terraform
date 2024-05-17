#EC2 SG 
resource "aws_security_group" "example" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.security_group_ingress_cidr_blocks
  }  
  
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.security_group_ingress_cidr_blocks
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.security_group_ingress_cidr_blocks
  }

  egress {
    description = "Outhbound Rule"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dhruv-EC2-SG"
  }
}

#EC2
resource "aws_instance" "myec2" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = data.aws_subnet.selected.id
  #make sure you use SG ID insted of SG name when our subnet is also define
  security_groups = [aws_security_group.example.id]

  # Define storage
  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = true
  }

  #Install apache
  user_data = <<-EOF
    #!/bin/bash
    echo "----------Installing apache2-----------"
    sudo apt update -y
    sudo apt install apache2 -y
    echo "-----------Completed Installing apache2----"
    EOF

  #Attach IAM Role
  iam_instance_profile = var.instance_profile

  tags = {
    Name = "Dhruv-EC2-Instance"
  }
}
