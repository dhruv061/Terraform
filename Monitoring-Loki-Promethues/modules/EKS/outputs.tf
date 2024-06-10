#Export Cluster Name
output "cluster_name" {
  value = aws_eks_cluster.dhruv-eks.name
}

#Export cluster endpoint
output "cluster_endpoint" {
  value = aws_eks_cluster.dhruv-eks.endpoint
}

#Export certficate
output "cluster_ca_certificate" {
  value = base64decode(aws_eks_cluster.dhruv-eks.certificate_authority[0].data)
}

