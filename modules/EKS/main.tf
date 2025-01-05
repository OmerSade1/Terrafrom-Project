module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = "my-cluster-eks"
  cluster_version = "1.31"

  enable_irsa = false
 
  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id = var.vpc_id

  control_plane_subnet_ids = [
    for az, subnet_id in var.public_subnet_az_map : subnet_id
    if az != "us-east-1e"
  ]

  subnet_ids = [
    for az, subnet_id in var.private_subnet_az_map : subnet_id
    if az != "us-east-1e"
  ]


   eks_managed_node_groups = {
    worker_nodes = {
      min_size       = 2
      max_size       = 6
      desired_size   = 4
      instance_types = [var.instance_type]
      
     iam_role_additional_policies = {
     "SecretsManagerReadWrite" = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
      }
    }
  }

  cluster_security_group_additional_rules = {
    allow_mysql_access = {
      description                = "Allow MySQL access to RDS from nodes"
      from_port                  = 3306
      to_port                    = 3306
      protocol                   = "tcp"
      type                       = "ingress" 
      source_node_security_group = true
    }
  }

 

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

data "aws_eks_cluster" "my_cluster" {
  name = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}


