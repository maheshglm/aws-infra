locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  customer_vars    = read_terragrunt_config(find_in_parent_folders("customer.hcl"))
  customer_name    = local.customer_vars.locals.customer_name
  environment_name = local.environment_vars.locals.environment
  aws_account_id   = local.account_vars.locals.aws_account_id
  aws_region       = local.region_vars.locals.aws_region
  project_name     = "wordpress"
  name_prefix      = format("%s-%s", local.project_name, local.environment_name)
}

terraform {
  source = "../../../../../../../modules//autoscaling_group/v6.5.0"
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

dependency "lb" {
  config_path = "../lb"
}

dependency "asg_sg" {
  config_path = "../asg_sg"
}

dependency "keypair" {
  config_path = "../asg_keypair"
}

inputs = {
  project     = local.project_name
  environment = local.environment_name

  //unique_id = dependency.unique_id.outputs.id

  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  health_check_type   = "ELB"
  vpc_zone_identifier = dependency.vpc.outputs.public_subnets
  target_group_arns   = dependency.lb.outputs.target_group_arns
  use_name_prefix     = true

  image_id        = "ami-0960ab670c8bb45f3"
  instance_type   = "t2.micro"
  user_data       = <<-EOF
              #!/bin/bash
              sudo apt-get -y update
              sudo apt-get -y install nginx
              EOF
  security_groups = dependency.asg_sg.outputs.security_group_ids
  key_name        = dependency.keypair.outputs.key_name
}