terraform {
  required_providers {
      kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
}

data "aws_eks_cluster" "cluster_name" {
  name = var.cluster_name
  depends_on = [ helm_release.karpenter ]
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = data.aws_eks_cluster.cluster_name.name
  depends_on = [ helm_release.karpenter ]
}


provider "kubectl" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
  load_config_file       = true
}

resource "kubectl_manifest" "karpenter_node_pool" {
  yaml_body = <<-YAML
    apiVersion: karpenter.sh/v1beta1
    kind: NodePool
    metadata:
      name: default
    spec:
      template:
        spec:
          nodeClassRef:
            name: default
          requirements:
            - key: "karpenter.k8s.aws/instance-category"
              operator: In
              values: ["t"]
            - key: "karpenter.k8s.aws/instance-family"
              operator: In
              values: ["t3"]
            - key: "karpenter.k8s.aws/instance-cpu"
              operator: In
              values: ["4"]
            - key: "karpenter.sh/capacity-type"
              operator: In
              values: ["spot", "on-demand"]
      limits:
        cpu: 300
      disruption:
        consolidationPolicy: WhenEmpty
        consolidateAfter: 30s
  YAML

  depends_on = [
    kubectl_manifest.karpenter_node_class
  ]
}



resource "kubectl_manifest" "karpenter_node_class" {
  yaml_body = <<-YAML
    apiVersion: karpenter.k8s.aws/v1beta1
    kind: EC2NodeClass
    metadata:
      name: default
    spec:
      amiFamily: AL2023
      role: ${var.node_karpenter_role_name}
      subnetSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${var.cluster_name}
      securityGroupSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${var.cluster_name}
      tags:
        karpenter.sh/discovery: ${var.cluster_name}
  YAML

  depends_on = [ data.aws_eks_cluster_auth.cluster_auth ]
  
}


