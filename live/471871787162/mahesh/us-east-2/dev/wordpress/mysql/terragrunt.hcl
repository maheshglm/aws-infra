locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  customer_vars    = read_terragrunt_config(find_in_parent_folders("customer.hcl"))

  aws_account_id        = local.account_vars.locals.aws_account_id
  main_domain_zone_id   = local.account_vars.locals.main_domain_zone_id
  main_domain_zone_name = local.account_vars.locals.main_domain_zone_name
  aws_region            = local.region_vars.locals.aws_region
  customer_name         = local.customer_vars.locals.customer_name
  environment_name      = local.environment_vars.locals.environment
  project_name          = "wordpress"
}

terraform {
  source = "../../../../../../../modules//rds/v5.0.0"
}

include {
  path = find_in_parent_folders()
}

dependency "unique_id" {
  config_path = "../../unique_id"
}

dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {
  customer_name = local.customer_name
  project       = local.project_name
  environment   = local.environment_name
  unique_id     = dependency.unique_id.outputs.id

  vpc_id              = dependency.vpc.outputs.vpc_id
  allowed_cidr_blocks = dependency.vpc.outputs.public_subnets_cidr_blocks

  subnet_ids         = dependency.vpc.outputs.database_subnets
  rds_db_name        = "${local.project_name}db"
  rds_engine         = "mysql"
  rds_engine_version = "8.0.27"

  //https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
  rds_instance_class = "db.t3.micro"
  rds_storage        = "20"
  rds_storage_type   = "gp2"

  rds_username = "wordpress"
  rds_port     = 3306

  multi_az                = "false"
  backup_retention_period = 1
  skip_final_snapshot     = true //defaults to false

  deletion_protection                 = false
  iam_database_authentication_enabled = true
  storage_encrypted                   = false //if true and kms_key_id is not specified aws generates own

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  # SSM Parameter Store Keys for rds variables.
  ssm_rds_username_path = format("/eks/%s/%s/%s/mysql_username", local.customer_name, local.project_name, local.environment_name)
  ssm_rds_password_path = format("/eks/%s/%s/%s/mysql_password", local.customer_name, local.project_name, local.environment_name)
}
