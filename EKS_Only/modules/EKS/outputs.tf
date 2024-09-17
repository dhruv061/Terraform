#Export Cluster Name
output "cluster_name" {
  value = aws_eks_cluster.dhruv-eks.name
}

