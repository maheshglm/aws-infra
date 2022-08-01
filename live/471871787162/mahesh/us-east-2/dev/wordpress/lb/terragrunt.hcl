locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  customer_vars    = read_terragrunt_config(find_in_parent_folders("customer.hcl"))

  customer_name    = local.customer_vars.locals.customer_name
  environment_name = local.environment_vars.locals.environment
  aws_account_id   = local.account_vars.locals.aws_account_id
  aws_region       = local.region_vars.locals.aws_region
  name_prefix      = format("%s-%s", local.customer_name, local.environment_name)
  project_name     = "wordpress"
}

terraform {
  source = "../../../../../../../modules//load_balancer/v6.10.0"
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

dependency "acm" {
  config_path = "../../acm"
}

dependency "lb_sg" {
  config_path = "../lb_sg"
}

inputs = {
  lb_type         = "alb"
  project         = local.project_name
  environment     = local.environment_name
  unique_id       = dependency.unique_id.outputs.id
  vpc_id          = dependency.vpc.outputs.vpc_id
  subnets         = dependency.vpc.outputs.public_subnets
  security_groups = dependency.lb_sg.outputs.security_group_ids
  idle_timeout    = 300

  target_groups = [
    {
      name_prefix      = "wpalb-" //max 6 chars
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
#      health_check = {
#        matcher = "200, 302"
#      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = dependency.acm.outputs.acm_certificate_arn
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect    = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]
}
