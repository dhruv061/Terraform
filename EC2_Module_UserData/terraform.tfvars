#----------------------------------------------For Provider---------------------------------------------#
aws_profile = "default"
aws_region  = "ap-south-1"

#----------------------------------------------For EC2-SG---------------------------------------------#
security_group_name                = "Dhruv-EC2-SG"
security_group_description         = "Sg for EC2"
security_group_ingress_cidr_blocks = ["0.0.0.0/0"]

#----------------------------------------------For EC2---------------------------------------------#
instance_type = "t2.micro"
volume_size   = 50
volume_type   = "gp3"

#-------------------------------------------------For IAM Role----------------------------------------#
iam_role_name = "Dhruv-S3-Access-Role"
