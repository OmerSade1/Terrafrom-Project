resource "kubernetes_namespace" "my_ingress_namespace" {
  metadata {
    name = "ingress"
  }
}

resource "helm_release" "external_nginx" {
  name             = "external"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  version          = "4.12.0-beta.0"
  set {
    name  = "controller.service.type"
    value = "NodePort"
  }

  set {
    name  = "controller.config.proxy-read-timeout"
    value = "600"  # Set read timeout (seconds)
  }

  set {
    name  = "controller.config.proxy-send-timeout"
    value = "600"  # Set send timeout (seconds)
  }

  set {
    name  = "controller.config.proxy-connect-timeout"
    value = "600"  # Set connect timeout (seconds)
  }

  depends_on = [ module.eks_blueprints_addons ]
}


resource "kubernetes_ingress_v1" "nginx_test_ingress" {
  metadata {
    name      = "nginx-test-ingress"
    namespace = "ingress"
    annotations = {
      "alb.ingress.kubernetes.io/ssl-redirect"    = 443
      "alb.ingress.kubernetes.io/scheme"          = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"     = "ip" 
      "alb.ingress.kubernetes.io/listen-ports"    = "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
      "alb.ingress.kubernetes.io/certificate-arn" = module.acm.acm_certificate_arn

    }
  }

  spec {
    ingress_class_name = "alb" 

    rule { 
      http {
        path {
          path = "/*"
          backend {
            service {
              name = "external-ingress-nginx-controller"
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
    module.eks_blueprints_addons,
    helm_release.external_nginx
  ]
}










