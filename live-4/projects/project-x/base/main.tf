# Provider block with region defined
provider "aws" {
  region = var.aws_region
}

module "unique_id" {
  source = "../../../../modules//unique_id/v1.0.0"
}

module "keypair" {
  source      = "../../../../modules//keypair/v1.0.1"
  key_name    = format("%s/%s", "/mahesh/${var.environment}/ec2_test_ssm", "private_key")
  customer    = var.customer_name
  environment = var.environment
  unique_id   = module.unique_id.id
}

module "security_groups" {
  source = "../../../../modules//security_group/v4.9.0"

  customer    = var.customer_name
  environment = var.environment
  unique_id   = module.unique_id.id

  custom_security_groups = [
    {
      security_group_name = format("%s-%s-ec2-sg", var.customer_name, var.environment)
      security_group_desc = "Security Group for ec2"
      vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id

      ingress_with_cidr_blocks = [
        { from_port = 22, to_port = 22, protocol = "tcp", description = "ssh access", cidr_blocks = "0.0.0.0/0" },
      ]
      egress_with_cidr_blocks  = [
        { from_port = 0, to_port = 0, protocol = "-1", description = "", cidr_blocks = "0.0.0.0/0" },
      ]
    }
  ]
}

module "ec2" {
  source    = "../../../../modules//ec2/v0.41.0"
  project   = var.project_name
  unique_id = module.unique_id.id

  vpc_id                    = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet                    = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  name                      = "testssm-ec2"
  instance_type             = var.instance_type
  security_groups           = module.security_groups.security_group_ids
  ami                       = var.ami
  ami_owner                 = var.ami_owner
  ssh_key_pair              = module.keypair.key_name
  delete_on_termination     = true
  //associate_public_ip_address = true
  ssm_patch_manager_enabled = true
}