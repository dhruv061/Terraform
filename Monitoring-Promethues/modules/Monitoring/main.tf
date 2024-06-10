#Create monitoring namespace
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.name_space
  }
}

#Create storage class for pvc that is used in grafana pod to store it's data!!
#All the grafana pod data is saved 
resource "kubernetes_storage_class" "grafana-storage-class" {
  metadata {
    name = var.storage_class_name
  }
  storage_provisioner = var.storage_provisioner
  parameters = {
    type = var.storage_type 
  }
}

#We use kube-prometheus-stack chart so promethius and grfana both is installed automatically
resource "helm_release" "monitoring" {
  name       = var.helm_release_name
  repository = var.helm_repository
  chart      = var.helm_chart
  namespace = var.name_space
  version    = var.helm_chart_version
  values     = [file("./modules/Monitoring/values.yaml")]
  depends_on = [ var.depends_of_monitoring, kubernetes_namespace.monitoring, kubernetes_storage_class.grafana-storage-class]
}
