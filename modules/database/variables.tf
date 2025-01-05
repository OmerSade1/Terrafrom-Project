variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "eks_security_group_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "private_subnet_az_map" {
  description = "Mapping of private subnets to their availability zones"
  type        = map(string)
}

variable "region" {
  type = string
}

variable "cidr_block" {
  type = string
}


