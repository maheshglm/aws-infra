locals {
  tags = {
    customer    = var.customer,
    project     = var.project,
    environment = var.environment,
    unique_id   = var.unique_id,
  }
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "1.0.1"

  key_name        = var.key_name
  create_key_pair = true
  public_key      = tls_private_key.this.public_key_openssh

  tags = merge({
    Terraform = "true"
  },
  local.tags
  )
}

resource "aws_ssm_parameter" "private_key" {
  name  = var.key_name
  type  = var.ssm_tier
  value = tls_private_key.this.private_key_pem

  tags = merge({
    Terraform = "true"
  },
  local.tags
  )
}