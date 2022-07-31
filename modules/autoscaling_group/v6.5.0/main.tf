locals {
  tags = {
    customer = var.customer,
    env      = var.environment,
    unique_id = var.unique_id,
    project  = var.project
  }
}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.0"

  name     = format("%s-%s-%s", var.customer, var.environment, var.unique_id)
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity  = var.desired_capacity




}