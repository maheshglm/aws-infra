locals {
  tags = {
    project_name     = var.project
    environment_name = var.environment
    unique_id        = var.unique_id
    customer_name    = var.customer_name
  }
}

module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.4.0"

  name                          = var.iam_user_name
  path                          = var.iam_user_path
  create_iam_access_key         = var.create_iam_access_key
  create_iam_user_login_profile = var.create_iam_user_login_profile
  iam_policy_arn                = var.iam_policy_arn
  force_destroy                 = var.force_destroy

  tags = merge({
    Terraform = "true"
  },
  local.tags
  )
}

resource "aws_ssm_parameter" "iam_access_key_id" {
  count = var.create_iam_access_key ? 1 : 0
  name  = format("%s-access-key-id", var.iam_user_name)
  type  = "String"
  value = module.iam_user.iam_access_key_id

  tags       = merge({
    Terraform = "true"
  },
  local.tags
  )
  depends_on = [
    module.iam_user,
  ]
}

resource "aws_ssm_parameter" "iam_access_key_secret" {
  count = var.create_iam_access_key ? 1 : 0
  name  = format("%s-access-key-secret", var.iam_user_name)
  type  = "SecureString"
  value = module.iam_user.iam_access_key_secret

  tags       = merge({
    Terraform = "true"
  },
  local.tags
  )
  depends_on = [
    module.iam_user,
  ]
}

resource "aws_iam_user_policy_attachment" "aws_access" {
  user       = module.iam_user.iam_user_name
  policy_arn = var.iam_policy_arn
}