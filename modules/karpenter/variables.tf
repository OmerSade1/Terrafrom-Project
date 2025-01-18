variable "cluster_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_certificate_authority_data" {
  type = string
}

variable "node_karpenter_role_name" {
  type = string
}

variable "karpenter_service_account_name" {
  type = string
}

variable "karpenter_queue_name" {
  type = string
}