locals {
  tags           = {
    customer  = var.customer,
    env       = var.environment,
    unique_id = var.unique_id,
    project   = var.project
  }
  ssm_key_prefix = format("/%s/%s/%s/%s", var.customer, var.environment, var.project)
}

module "keypair" {
  source = "../../keypair/v1.0.1"

  key_name    = format("%s/%s", local.ssm_key_prefix, "private_key")
  customer    = var.customer
  environment = var.environment
  unique_id   = var.unique_id
}

module "security_group" {
  source = "../../security_group/v4.9.0"

  customer               = var.customer
  environment            = var.environment
  unique_id              = var.unique_id
  custom_security_groups = var.custom_security_groups
}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.0"

  # Autoscaling group
  name                = format("asg-%s-%s-%s", var.project, var.environment, var.unique_id)
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  health_check_type   = var.health_check_type
  vpc_zone_identifier = var.vpc_zone_identifier
  use_name_prefix     = var.use_name_prefix
  target_group_arns   = var.target_group_arns

  # Launch template
  launch_template_name = format("lt-%s-%s-%s", var.project, var.environment, var.unique_id)
  image_id             = var.image_id
  instance_type        = var.instance_type
  user_data            = base64encode(var.user_data)
  security_groups      = module.security_group.security_group_ids
  key_name             = module.keypair.key_name

  tags = merge({
    Terraform = "true"
  },
  local.tags
  )
}

