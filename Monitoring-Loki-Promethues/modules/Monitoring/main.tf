#Create monitoring namespace
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.name_space
  }
}

#----------------------------"kube-prometheus-stack" helm chart (Grafana & Promethues)----------------------#
#Create storage class for pvc that is used in grafana pod to store it's data!!
#All the grafana pod data is saved 
resource "kubernetes_storage_class" "grafana-storage-class" {
  metadata {
    name = "grafana-storage-class"
  }
  storage_provisioner = "kubernetes.io/aws-ebs"
  parameters = {
    type = "gp2" 
  }
}

#Install Grafana & Promethues using "kube-prometheus-stack" helm chart
#We use kube-prometheus-stack chart so promethius and grfana both is installed automatically
resource "helm_release" "monitoring" {
  name       = "monitoring"
  chart      = "./modules/Monitoring/Helm-Charts/kube-prometheus-stack"
  namespace = var.name_space
  depends_on = [ var.depends_of_monitoring, kubernetes_namespace.monitoring, kubernetes_storage_class.grafana-storage-class]
}

#----------------------------"loki-stack" helm chart (Loki)--------------------------------------------------#
#Install Loki using "loki-stack" helm chart
#We use kube-prometheus-stack chart so promethius and grfana both is installed automatically
resource "helm_release" "loki-monitoring" {
  name       = "loki"
  chart      = "./modules/Monitoring/Helm-Charts/loki-stack"
  namespace = var.name_space
  depends_on = [ var.depends_of_monitoring, kubernetes_namespace.monitoring, kubernetes_storage_class.grafana-storage-class]
}

