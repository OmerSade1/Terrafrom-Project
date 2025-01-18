output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_version" {
  value = module.eks.cluster_version
}

output "cluster_endpoint" {
  value = data.aws_eks_cluster.my_cluster.endpoint
}


output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "oidc_provider_arn" {
  description = "The ARN of the IAM OIDC provider"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "oidc_provider_url" {
  value = aws_iam_openid_connect_provider.eks.url
}

output "eks_region" {
  value = data.aws_region.current.name
}

output "eks_security_group_id" {
  value = module.eks.cluster_security_group_id
  description = "The security group ID associated with the EKS cluster"
}

output "node_security_group_id" {
  value = module.eks.node_security_group_id
}


output "node_karpenter_role_name" {
  value = module.karpenter.node_iam_role_name
}

output "karpenter_service_account_name" {
  value = module.karpenter.service_account
}

output "karpenter_queue_name" {
   value = module.karpenter.queue_name
}