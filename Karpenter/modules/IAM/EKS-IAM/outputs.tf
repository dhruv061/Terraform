#Export EKS Cluster  & This is also used for Depends on main.tf in root level
output "eks_cluster_service_role_ARN" {
  value = aws_iam_role.EksClusterServiceRole.arn
}

#Export EKS Node Role ARN & This is also used for Depends on main.tf in root level
output "eks_node_role_ARN" {
  value = aws_iam_role.AmazonEKSNodeRole.arn
}

#Exoprt instace profile 
output "instace_profile_name" {
  value = aws_iam_instance_profile.karpenter.name
}

