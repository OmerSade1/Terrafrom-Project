variable "instance_type" {
  description = "choose instance type"
  type = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_az_map" {
  description = "Mapping of public subnets to their availability zones"
  type        = map(string)
}

variable "private_subnet_az_map" {
  description = "Mapping of private subnets to their availability zones"
  type        = map(string)
}

variable "environment" {
  type = string
}

variable "region" {
  description = "the region to up"
  type = string
}


