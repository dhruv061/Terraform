#-------------------------------------------------For IAM Role--------------------------------------------------#
#Create IAM Role
resource "aws_iam_role" "s3_access_role" {
  name               = var.iam_role_name
  #trust policy
  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
    EOF
}

#Attach Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "s3_fullaccess_attachment" {
  role = aws_iam_role.s3_access_role.name
  #Policy ARN get from IAM console inside policy section 
  #S3 full access policy
  policy_arn = data.aws_iam_policy.s3_full_access_policy.arn
}

#Create Instace Profile that is used to assign this role into the EC2 instace.
resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "ec2_s3_profile"
  role = aws_iam_role.s3_access_role.name
}

#-------------------------------------------------For EC2 --------------------------------------------------#
#EC2 SG 
resource "aws_security_group" "example" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.security_group_ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#EC2
resource "aws_instance" "myec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.selected.id
  #make sure you use SG ID insted of SG name when our subnet is also define
  security_groups = [aws_security_group.example.id]

  # Define storage
  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = true
  }

  #Attach IAM Role
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name

  tags = {
    Name = "Dhruv-EC2-Instance"
  }
}



