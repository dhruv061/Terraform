resource "kubernetes_namespace" "grafana" {
  metadata {
    name = var.name_space
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = var.name_space
  version    = "7.0.0" 
  values     = [file("./modules/Grafana/values.yaml")]
  depends_on = [ var.depends_on_grafana ]
}