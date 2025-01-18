resource "helm_release" "external_secrets" {
  name       = "my-external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "0.12.1"

  set {
    name  = "installCRDs"
    value = "true"  
  }
}
