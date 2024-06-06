#Add-on: vpc-cni
resource "aws_eks_addon" "vpc-cni" {
  cluster_name = var.cluster_name
  addon_name   = var.eks_addOn_vpc-cni
}

#Add-on: kube-proxy
resource "aws_eks_addon" "kube-proxy" {
  cluster_name = var.cluster_name
  addon_name   = var.eks_addOn_kube-proxy
}

#Add-on: eks-pod-identity-agent
resource "aws_eks_addon" "eks-pod-identity-agent" {
  cluster_name = var.cluster_name
  addon_name   = var.eks_addOn_eks-pod-identity-agent
}

#Add-on: coredns
resource "aws_eks_addon" "coredns" {
  cluster_name = var.cluster_name
  addon_name   = var.eks_addOn_coredns
}

#Add-on: EBS Drive
resource "aws_eks_addon" "aws-ebs-csi-driver" {
  cluster_name = var.cluster_name
  addon_name   = var.eks_addOn_aws-ebs-csi-driver
}
