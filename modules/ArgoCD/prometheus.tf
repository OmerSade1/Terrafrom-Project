resource "helm_release" "kube_prometheus_stack" {
  name       = "my-kube-prometheus-stack"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  create_namespace = true
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "67.8.0"
}

