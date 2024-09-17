#----------------------------------------------For Provider---------------------------------------------#
aws_profile = "default"
aws_region  = "eu-west-3"

#----------------------------------------------For IAM Policy---------------------------------------------#
eks_cluster_role_name = "Dhruv-EksClusterServiceRole"
eks_node_group_name   = "Dhruv-AmazonEKSNodeRole"

#----------------------------------------------For EKS-SG---------------------------------------------#
eks_security_group_name                = "Dhruv-EKS-SG"
eks_security_group_description         = "SG of EKS"
eks_vpc_id                             = "vpc-03fe07147b4940607"
vpc_subnet_ids                         = ["subnet-0a6c734bc141fdab2", "subnet-0b3c9225dbe1343f4", "subnet-08a12589cd4b49fdd"]
eks_security_group_ingress_cidr_blocks = ["0.0.0.0/0"]

#---------------------------------------------FOR EKS-----------------------------------------------------#
cluster_name = "Dhruv-EKS-Terraform"

#---------------------------------------------FOR Node Group-----------------------------------------------------#
node_group_name = "Dhruv-node-group"
capacity_type   = "ON_DEMAND"
disk_size       = 20
instance_types  = ["t2.small"]
scaling_config = {
  desired_size = 2
  max_size     = 2
  min_size     = 1
}
update_config = {
  max_unavailable = 1
}

#---------------------------------------EKS-AddOn----------------------------------------------------#
eks_addOn_vpc-cni                = "vpc-cni"
eks_addOn_kube-proxy             = "kube-proxy"
eks_addOn_eks-pod-identity-agent = "eks-pod-identity-agent"
eks_addOn_coredns                = "coredns"
aws_ebs_csi_driver               = "aws-ebs-csi-driver"