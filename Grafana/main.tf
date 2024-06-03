terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.6"
    }
  }

  required_version = ">= 0.14.9"
}

#------------------------------------VPC------------------------------------------------#
module "VPC" {
  source = "./modules/VPC"

  vpc_cidr                           = var.vpc_cidr
  public_subnet_cidrs                = var.public_subnet_cidrs
  private_subnet_cidrs               = var.private_subnet_cidrs
  public_rt_destination_cidr_block   = var.public_rt_destination_cidr_block
  private_rt_destination_cidr_block  = var.private_rt_destination_cidr_block
  security_group_name                = var.vpc_security_group_name
  security_group_description         = var.vpc_security_group_description
  security_group_ingress_cidr_blocks = var.vpc_security_group_ingress_cidr_blocks
}

#------------------------------------IAM Policy---------------------------------------------#
module "IAMPolicy" {
  source = "./modules/IAMPolicy"

  eks_cluster_role_name = var.eks_cluster_role_name
  eks_node_group_name   = var.eks_node_group_name
}

#----------------------------------------EKS----------------------------------------------------#
module "EKS" {
  source = "./modules/EKS"

  security_group_name                = var.eks_security_group_name
  security_group_description         = var.eks_security_group_description
  vpc_id                             = module.VPC.vpc_id
  security_group_ingress_cidr_blocks = var.eks_security_group_ingress_cidr_blocks
  cluster_name                       = var.cluster_name
  subnet_ids                         = [module.VPC.vpc_subnet_id_1, module.VPC.vpc_subnet_id_2]
  eks_Cluster_role_Arn               = module.IAMPolicy.eks_cluster_service_role_ARN
  eks_depends_on                     = [module.VPC.vpc_id, module.IAMPolicy.AmazonEKSClusterPolicy_ARN]
}

#---------------------------------------EKS-NG----------------------------------------------------#
module "EKS-NG" {
  source = "./modules/NG"

  cluster_name          = module.EKS.cluster_name
  node_group_name       = var.node_group_name
  eks_node_grp_role_Arn = module.IAMPolicy.eks_node_role_ARN
  capacity_type         = var.capacity_type
  subnet_ids            = [module.VPC.vpc_subnet_id_1, module.VPC.vpc_subnet_id_2]
  disk_size             = var.disk_size
  instance_types        = var.instance_types
  scaling_config        = var.scaling_config
  update_config         = var.update_config
  ng_depends_on = [module.IAMPolicy.AmazonEKSWorkerNodePolicy_ARN, module.IAMPolicy.AmazonEKS_CNI_Policy_ARN, module.IAMPolicy.AmazonEC2ContainerRegistryReadOnly_ARN, module.IAMPolicy.CloudWatchLogsFullAccess_ARN, module.IAMPolicy.AmazonEBSCSIDriverPolicy_ARN]
}

#---------------------------------------EKS-AddOn----------------------------------------------------#
module "EKS-AddOn" {
  source = "./modules/EKS-AddOn"

  cluster_name = module.EKS.cluster_name
  eks_addOn_vpc-cni = var.eks_addOn_vpc-cni
  eks_addOn_kube-proxy = var.eks_addOn_kube-proxy
  eks_addOn_eks-pod-identity-agent = var.eks_addOn_eks-pod-identity-agent
  eks_addOn_coredns = var.eks_addOn_coredns
  eks_addOn_aws-ebs-csi-driver = var.aws_ebs_csi_driver
}

module "grafana" {
  source = "./modules/Grafana"

  depends_on_grafana = module.EKS.cluster_name
  name_space = var.name_space
}