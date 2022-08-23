locals {
  auth_token = var.rds_password != "" ? var.rds_password : random_password.auth_token[0].result
  name       = format("%s-%s-%s", var.customer_name, var.project, var.environment)
  tags       = {
    customer_name = var.customer_name,
    project       = var.project,
    environment   = var.environment,
    unique_id     = var.unique_id,
  }
}

resource "random_password" "auth_token" {
  count   = 1
  length  = 64
  special = false
}

resource "aws_security_group" "rds_sg" {
  name        = format("rds-security-group-%s", local.name)
  description = "Allow inbound connection to rds"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ "Name" = format("rds-security-group-%s", local.name) }, local.tags,
  var.additional_tags)
}

resource "aws_db_subnet_group" "db-subnet" {
  name       = format("rds-db-subnet-group-%s", local.name)
  subnet_ids = var.subnet_ids

  tags = merge(
  var.tags,
  {
    "Name" = local.name
  },
  )
}


module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.0.0"

  identifier                          = format("rds-%s", local.name)
  engine                              = var.rds_engine
  engine_version                      = var.rds_engine_version
  major_engine_version                = var.major_engine_version
  instance_class                      = var.rds_instance_class
  allocated_storage                   = var.rds_storage
  max_allocated_storage               = var.max_rds_storage
  storage_type                        = var.rds_storage_type
  db_name                             = var.rds_db_name
  username                            = var.rds_username
  password                            = local.auth_token
  port                                = var.rds_port
  subnet_ids                          = var.subnet_ids
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  vpc_security_group_ids              = [aws_security_group.rds_sg.id]
  maintenance_window                  = var.maintenance_window
  backup_window                       = var.backup_window
  auto_minor_version_upgrade          = var.auto_minor_version_upgrade
  multi_az                            = var.multi_az
  backup_retention_period             = var.backup_retention_period
  storage_encrypted                   = var.storage_encrypted
  kms_key_id                          = var.kms_key_id
  create_monitoring_role              = var.create_monitoring_role
  skip_final_snapshot                 = var.skip_final_snapshot
  parameters                          = var.parameters
  copy_tags_to_snapshot               = true
  create_db_parameter_group           = false
  db_subnet_group_name                = aws_db_subnet_group.db-subnet.name

  tags = merge({
    Owner = "user"
  },
  local.tags,
  var.additional_tags
  )
}

resource "aws_ssm_parameter" "rds_password" {
  depends_on = [module.db]
  name       = var.ssm_rds_password_path
  type       = "SecureString"
  value      = module.db.db_instance_password
  overwrite  = true
}

resource "aws_ssm_parameter" "rds_username" {
  depends_on = [module.db]
  name       = var.ssm_rds_username_path
  type       = "SecureString"
  value      = module.db.db_instance_username
  overwrite  = true
}