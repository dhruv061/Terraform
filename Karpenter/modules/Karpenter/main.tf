#Install Karpenter
resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "v0.33.0"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.karpenter_controller_arn
  }

  set {
    name  = "settings.clusterName"  
    value = var.cluster_name
  }

  set {
    name  = "settings.aws.clusterEndpoint"
    value = var.cluster_endpoint
  }

  set {
    name  = "settings.aws.defaultInstanceProfile"
    value = var.instace_profile
  }

  depends_on = [var.karpenter_depends_on]
}

