#----------------------------------------------For Provider---------------------------------------------#
aws_profile = "default"
aws_region  = "ap-south-1"

#----------------------------------------------For VPC---------------------------------------------#
vpc_cidr                               = "10.0.0.0/16"
public_subnet_cidrs                    = ["10.0.0.0/18", "10.0.64.0/19", "10.0.96.0/19"]
private_subnet_cidrs                   = ["10.0.128.0/18", "10.0.192.0/19", "10.0.224.0/19"]
public_rt_destination_cidr_block       = "0.0.0.0/0"
private_rt_destination_cidr_block      = "0.0.0.0/0"
vpc_security_group_name                = "Dhruv-VPC-SG"
vpc_security_group_description         = "SG for VPC"
vpc_security_group_ingress_cidr_blocks = ["0.0.0.0/0"]

#----------------------------------------------For EKS IAM ---------------------------------------------#
eks_cluster_role_name = "Dhruv-EksClusterServiceRole"
eks_node_group_name   = "Dhruv-AmazonEKSNodeRole"
instace_profile_name = "KarpenterNodeInstanceProfile"

#---------------------------------------For Karpenter IAM-----------------------------------------------------#
karpenter_controller_name = "karpenter-controller"
karpenter_controller_policy_name = "karpenter-controller-policy"

#----------------------------------------------For EKS-SG---------------------------------------------#
eks_security_group_name                = "Dhruv-EKS-SG"
eks_security_group_description         = "SG of EKS"
eks_security_group_ingress_cidr_blocks = ["0.0.0.0/0"]

#---------------------------------------------FOR EKS-----------------------------------------------------#
cluster_name = "Dhruv-EKS-Terraform"

#---------------------------------------------FOR Node Group-----------------------------------------------------#
node_group_name = "dhruv-node-group"
capacity_type   = "ON_DEMAND"
disk_size       = 20
instance_types  = ["t3.medium"]
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

