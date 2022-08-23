module "lb_sg" {
  source = "../../../../modules//security_group/v4.9.0"

  customer    = var.customer_name
  environment = var.environment
  unique_id   = module.unique_id.id

  custom_security_groups = [
    {
      security_group_name = format("%s-%s-wordpress-alb-sg", var.customer_name, var.environment)
      security_group_desc = "Security Group for Wordpress Load balancer group"
      vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id

      ingress_with_cidr_blocks = [
        { from_port = 443, to_port = 443, protocol = "tcp", description = "Https traffic", cidr_blocks = "0.0.0.0/0" },
        { from_port = 80, to_port = 80, protocol = "tcp", description = "Http traffic", cidr_blocks = "0.0.0.0/0" },
      ]
      egress_with_cidr_blocks  = [
        { from_port = 0, to_port = 0, protocol = "-1", description = "", cidr_blocks = "0.0.0.0/0" },
      ]
    }
  ]
}

module "lb" {
  source = "../../../../modules//load_balancer/v6.10.0"

  depends_on = [module.mysql, module.lb_sg]

  lb_type         = "alb"
  project         = var.project_name
  environment     = var.environment
  unique_id       = module.unique_id.id
  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets         = data.terraform_remote_state.vpc.outputs.public_subnets
  security_groups = module.lb_sg.security_group_ids
  idle_timeout    = 300

  target_groups = [
    {
      name_prefix      = "wpalb-" //max 6 chars
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      health_check     = {
        matcher = "200,302"
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.acm_cert_arn
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