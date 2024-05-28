#-----------------------------------Fetch Policy for EKS Cluster-----------------------------------------#
#Fetch AmazonEKSClusterPolicy for EKS
data "aws_iam_policy" "AmazonEKSClusterPolicy" {
  name = "AmazonEKSClusterPolicy"
}

#-----------------------------------Fetch Policy for EKS Cluster Node Group-----------------------------------------#
#Fetch AmazonEKSWorkerNodePolicy for EKS-NG
data "aws_iam_policy" "AmazonEKSWorkerNodePolicy" {
  name = "AmazonEKSWorkerNodePolicy"
}

#Fetch AmazonEKS_CNI_Policy for EKS-NG
data "aws_iam_policy" "AmazonEKS_CNI_Policy" {
  name = "AmazonEKS_CNI_Policy"
}

#Fetch AmazonEC2ContainerRegistryReadOnly for EKS-NG
data "aws_iam_policy" "AmazonEC2ContainerRegistryReadOnly" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

#Fetch CloudWatchLogsFullAccess for EKS-NG
data "aws_iam_policy" "CloudWatchLogsFullAccess" {
  name = "CloudWatchLogsFullAccess"
}

#Fetch AmazonEBSCSIDriverPolicy for EKS-NG
data "aws_iam_policy" "AmazonEBSCSIDriverPolicy" {
  name = "AmazonEBSCSIDriverPolicy"
}

