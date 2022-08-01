locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  customer_vars    = read_terragrunt_config(find_in_parent_folders("customer.hcl"))

  customer_name    = local.customer_vars.locals.customer_name
  environment_name = local.environment_vars.locals.environment
  aws_account_id   = local.account_vars.locals.aws_account_id
  aws_region       = local.region_vars.locals.aws_region
  ssm_key_path     = format("/%s/%s/wordpress_asg", local.customer_name, local.environment_name)
}

terraform {
  source = "../../../../../../../modules//keypair/v1.0.1"
}

include {
  path = find_in_parent_folders()
}

dependency "unique_id" {
  config_path = "../../unique_id"
}

inputs = {
  key_name    = format("%s/%s", local.ssm_key_path, "private_key")
  customer    = local.customer_name
  environment = local.environment_name
  unique_id   = dependency.unique_id.outputs.id
}

# aws ssm get-parameter --region us-east-2 --name /mahesh/dev/wordpress_asg/private_key --with-decryption | jq .Parameter.Value -r > private_key.pem