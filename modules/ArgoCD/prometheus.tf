resource "helm_release" "kube_prometheus_stack" {
  name       = "my-kube-prometheus-stack"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  create_namespace = true
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "67.8.0"
    set {
    name  = "prometheus.ingress.enabled"
    value = "true"
  }

   set {
    name  = "prometheus.ingress.ingressClassName"
    value = "nginx"
  }

  set {
    name  = "prometheus.ingress.hosts[0]"
    value = "prometheus.omsad.xyz"
  }

  set {
    name = "prometheus.ingress.paths[0]"
    value = "/"
  }

  set {
    name  = "grafana.ingress.enabled"
    value = "true"
  }

  set {
    name  = "grafana.ingress.ingressClassName"
    value = "nginx"
  }
 
  set {
    name  = "grafana.ingress.hosts[0]"
    value = "grafana.omsad.xyz"
  }

  set {
    name  = "grafana.ingress.path"
    value = "/"
  }
}

