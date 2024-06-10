#Export EKS Cluster  & This is also used for Depends on main.tf in root level
output "eks_cluster_service_role_ARN" {
  value = aws_iam_role.EksClusterServiceRole.arn
}

output "AmazonEKSClusterPolicy_ARN" {
  value = aws_iam_role_policy_attachment.AmazonEKSClusterPolicy.policy_arn
}

#Export EKS Node Role ARN & This is also used for Depends on main.tf in root level
output "eks_node_role_ARN" {
  value = aws_iam_role.AmazonEKSNodeRole.arn
}

output "AmazonEKSWorkerNodePolicy_ARN" {
  value = aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy.policy_arn
}

output "AmazonEKS_CNI_Policy_ARN" {
  value = aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy.policy_arn
}

output "AmazonEC2ContainerRegistryReadOnly_ARN" {
  value = aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly.policy_arn
}

output "CloudWatchLogsFullAccess_ARN" {
  value = aws_iam_role_policy_attachment.CloudWatchLogsFullAccess.policy_arn
}

output "AmazonEBSCSIDriverPolicy_ARN" {
  value = aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy.policy_arn
}
