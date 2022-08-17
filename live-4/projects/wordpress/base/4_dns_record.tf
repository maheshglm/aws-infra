module "dns" {
  source = "../../../../modules//dns_record/v1.0.0"

  zone_id = var.main_domain_zone_id
  name    = "wordpress-dev.letsdevops.link"
  type    = "CNAME"
  ttl     = 60
  records = [module.lb.lb_dns_name]
}

