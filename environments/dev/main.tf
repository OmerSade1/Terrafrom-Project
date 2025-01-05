module "networking" {
  source = "../../modules/networking"
  cidr_block  = var.cidr_block
  region      = var.region
  environment = var.environment
  domain_name = var.domain_name
}

module "ECR" {
  source = "../../modules/ECR"
  assume_role = var.assume_role
  environment = var.environment
}

module "eks" {
  source = "../../modules/EKS"
  depends_on = [module.networking]
  vpc_id                = module.networking.vpc_id
  public_subnet_az_map  = module.networking.public_subnet_az_map
  private_subnet_az_map = module.networking.private_subnet_az_map
  instance_type = var.instance_type
  environment = var.environment
  region = var.region
}
 
module "ArgoCD" {
  source = "../../modules/ArgoCD"
  cluster_name = module.eks.cluster_name
  cluster_version = module.eks.cluster_version
  cluster_endpoint = module.eks.cluster_endpoint
  vpc_id = module.networking.vpc_id
  oidc_provider_arn = module.eks.oidc_provider_arn
  environment = var.environment
  eks_region = module.eks.eks_region
  domain_name = var.domain_name
  zone_id = module.networking.zone_id
}

module "database" {
  depends_on = [ module.eks ]
  source = "../../modules/database"
  environment = var.environment
  private_subnet_az_map = module.networking.private_subnet_az_map
  eks_security_group_id = module.eks.eks_security_group_id
  vpc_id = module.networking.vpc_id
  region = var.region
  cidr_block = var.cidr_block
}