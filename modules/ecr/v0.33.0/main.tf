locals {
  tags = {
    customer_name = var.customer,
    project       = var.project,
    env           = var.environment, # environment tag key isn't allowed by AWS!
  }
}

module "ecr" {
  source  = "cloudposse/ecr/aws"
  version = "0.33.0"

  # general settings
  delimiter                = var.delimiter
  enable_lifecycle_policy  = var.enable_lifecycle_policy
  enabled                  = var.enabled
  encryption_configuration = var.encryption_configuration

  # images configuration
  image_tag_mutability = var.image_tag_mutability
  label_key_case       = var.label_key_case
  image_names          = var.image_names
  max_image_count      = var.max_image_count
  protected_tags       = var.protected_tags
  scan_images_on_push  = var.scan_images_on_push

  # access related
  principals_full_access     = var.principals_full_access
  principals_lambda          = var.principals_lambda
  principals_readonly_access = var.principals_readonly_access

  # Updating tags
  tags = merge({
    Terraform = "true"
  },
  local.tags
  )
}