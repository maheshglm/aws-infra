locals {
  tags = {
    customer  = var.customer,
    env       = var.environment,
    unique_id = var.unique_id,
    project   = var.project
  }
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
  security_groups      = var.security_groups
  key_name             = var.key_name

  tags = merge({
    Terraform = "true"
  },
  local.tags
  )

}