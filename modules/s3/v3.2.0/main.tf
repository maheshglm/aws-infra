locals {
  name = format("%s-%s-%s", var.customer_name, var.project, var.environment)
  tags = {
    customer_name    = var.customer_name,
    project_name     = var.project,
    environment_name = var.environment,
    unique_id        = var.unique_id,
  }
}

module "s3-bucket" {
  for_each = var.s3_bucket_list
  source   = "terraform-aws-modules/s3-bucket/aws"
  version  = "3.2.0"

  bucket                  = each.value
  acl                     = var.acl
  restrict_public_buckets = var.restrict_public_buckets
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  cors_rule               = var.cors_rule
  lifecycle_rule          = var.lifecycle_rule
  logging                 = var.logging
  force_destroy           = var.force_destroy
  policy                  = var.policy
  attach_policy           = var.attach_policy

  versioning = {
    enabled = false
  }
  tags = merge({
    Terraform = "true"
  },
  local.tags
  ,
  var.additional_tags
  )
}