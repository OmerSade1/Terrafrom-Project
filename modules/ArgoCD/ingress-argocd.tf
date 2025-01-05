resource "kubernetes_ingress_v1" "argocd_ingress" {
  metadata {
    name      = "argocd-ingress"
    namespace = "argocd"
  }

  spec {
    ingress_class_name = "nginx"
    rule {
      host = "argocd.omsad.xyz"
      http {
        path {
          path = "/"
          backend {
            service {
              name = "argocd-server"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
    depends_on = [
    helm_release.external_nginx
  ]
}
