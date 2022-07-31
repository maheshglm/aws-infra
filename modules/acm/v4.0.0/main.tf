locals {
  tags = {
    customer = var.customer,
    project  = var.project,
    env      = var.environment,
    unique_id = var.unique_id
  }
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "4.0.0"

  domain_name                        = var.domain_name
  zone_id                            = var.zone_id
  subject_alternative_names          = var.subject_alternative_names
  validation_method                  = var.validation_method
  validate_certificate               = var.validate_certificate
  validation_allow_overwrite_records = var.validation_allow_overwrite_records
  create_certificate                 = var.create_certificate

  wait_for_validation = true

  tags = merge({
    Terraform = "true"
  },
  local.tags
  )

}
