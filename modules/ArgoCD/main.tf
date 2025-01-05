module "argocd" {
  source = "aigisuk/argocd/kubernetes"
  argocd_chart_version = "7.7.11"
  insecure = true
}

   
  










