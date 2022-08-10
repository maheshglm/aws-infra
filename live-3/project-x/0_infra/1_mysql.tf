module "mysql" {
  source = "../../../modules//rds/v5.0.0"

  depends_on = [module.vpc]

  customer_name = var.customer_name
  project       = var.project_name
  environment   = var.environment
  unique_id     = module.unique_id.id

  vpc_id              = module.vpc.vpc_id
  allowed_cidr_blocks = module.vpc.private_subnets_cidr_blocks

  subnet_ids           = module.vpc.database_subnets
  rds_db_name          = "${var.project_name}db"
  rds_engine           = "mysql"
  rds_engine_version   = "8.0.27"
  major_engine_version = "8.0"

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

  parameters            = [
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
  ssm_rds_username_path = format("/%s/%s/%s/mysql_username", var.customer_name, var.project_name, var.environment)
  ssm_rds_password_path = format("/%s/%s/%s/mysql_password", var.customer_name, var.project_name, var.environment)
}