locals {
  tags = {
    customer    = var.customer,
    project     = var.project,
    environment = var.environment,
    unique_id   = var.unique_id,
    resource    = var.resource,
    service     = var.service,
  }
}

resource "aws_ssm_parameter" "ssm" {
  name        = var.ssm_name
  type        = var.type
  value       = var.ssm_value
  overwrite   = var.overwrite
  description = var.description

  tags = merge({
    Terraform = "true"
  },
  local.tags
  )
}