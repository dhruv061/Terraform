#Export Cluster Name
output "cluster_name" {
  value = aws_eks_cluster.dhruv-eks.name
}

#Export cluster endpoint
output "cluster_endpoint" {
  value = aws_eks_cluster.dhruv-eks.endpoint
}

#Export cluster id
output "cluster_id" {
  value = aws_eks_cluster.dhruv-eks.id
}

#Export certficate
output "cluster_ca_certificate" {
  value = base64decode(aws_eks_cluster.dhruv-eks.certificate_authority[0].data)
}

#Export OIDC url
output "oidc_url" {
  value = aws_iam_openid_connect_provider.eks_oidc.url
}

#Export OIDC arn
output "oidc_arn" {
  value = aws_iam_openid_connect_provider.eks_oidc.arn
}

