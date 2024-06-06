#----------------------------------------------Create EKS SG-------------------------------------------------#
#EKS SG 
resource "aws_security_group" "eks_sg" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id
  depends_on = [var.vpc_id]

  ingress {
    description = "Allow All Trafic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
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
    Name = "Dhruv-VPC-SG"
  }
}

#Creating EKS Cluster
resource "aws_eks_cluster" "dhruv-eks" {
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  name     = var.cluster_name
  role_arn = var.eks_Cluster_role_Arn

  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = [ aws_security_group.eks_sg.id ]
  }

  tags = {
    "Name" = "MyEKS"
  }

  depends_on = [var.eks_depends_on]
}

#Create OIDC Provider
resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.dhruv-eks.identity.0.oidc.0.issuer
}



