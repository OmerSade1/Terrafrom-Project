output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_az_map" {
  value = zipmap(local.az, module.vpc.public_subnets)
  description = "Mapping of public subnets to their availability zones"
}

output "private_subnet_az_map" {
  value = zipmap(local.az, module.vpc.private_subnets)
  description = "Mapping of private subnets to their availability zones"
}





