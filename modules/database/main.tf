# Fetch the existing secret from Secrets Manager
data "aws_secretsmanager_secret" "rds_secret" {
  name = "mysql/secrets"
}

data "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = data.aws_secretsmanager_secret.rds_secret.id
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)
}

module "db" {
  depends_on = [ helm_release.external_secrets ]
  source = "terraform-aws-modules/rds/aws"

  identifier         = "db-mysql"
  engine             = "mysql"
  engine_version     = "8.4.3"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  storage_type       = "gp2"
  port               = 3306
  

  manage_master_user_password = false
  
  iam_database_authentication_enabled = true

  db_name = local.db_credentials["DB_NAME"]
  username = local.db_credentials["username"]
  password = local.db_credentials["DB_PASSWORD"]

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Owner       = "user"
    Environment = var.environment
  }

  create_db_subnet_group = true
  subnet_ids             = [for az, subnet_id in var.private_subnet_az_map : subnet_id]

  family                = "mysql8.4"
  major_engine_version  = "8.4"

  create_db_option_group = false

  create_db_parameter_group = false


}

