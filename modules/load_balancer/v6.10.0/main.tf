locals {
  tags = {
    customer  = var.customer,
    env       = var.environment,
    unique_id = var.unique_id,
    project   = var.project
  }
}

module "security_group" {
  source                 = "../../security_group/v4.9.0"
  customer               = var.customer
  environment            = var.environment
  unique_id              = var.unique_id
  custom_security_groups = var.custom_security_groups
}

module "lb" {

  source             = "terraform-aws-modules/alb/aws"
  version            = "6.10.0"
  name               = format("%s-%s-%s-%s", var.lb_type, var.project, var.environment, var.unique_id)
  load_balancer_type = var.lb_type == "alb" ? "application" : "network"
  vpc_id             = var.vpc_id
  subnets            = var.subnets
  security_groups    = module.security_group.security_group_ids
  http_tcp_listeners = var.http_tcp_listeners
  https_listeners    = var.https_listeners
  target_groups      = var.target_groups
  idle_timeout       = var.idle_timeout
  tags               = merge({
    Terraform = "true"
  },
  local.tags
  )
}