variable "cluster_name" {
  description = "cluster_name"
  type = string
}

variable "cluster_version" {
  description = "cluster_version"
  type = string
}

variable "cluster_endpoint" {
  description = "cluster_endpoint"
  type = string
}


variable "vpc_id" {
  description = "vpc_id"
  type = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the IAM OIDC provider"
  type        = string
}

variable "environment" {
  type = string
}

variable "eks_region" {
  type = string
}

variable "zone_id" {
  description = "my zone_id"
  type = string
}

variable "domain_name" {
  description = "my DNS"
  type = string
}



