data "terraform_remote_state" "sg" {
  backend = "local"

  config = {
    path = "../terraform.tfstate"
  }
}

module "unique_id" {
  source = "../../../modules//unique_id/v1.0.0"
}

module "sg" {
  source = "../../../modules//security_group/v4.9.0"

  unique_id   = module.unique_id.id
  customer    = var.customer_name
  environment = var.environment

  custom_security_groups = [
    {
      security_group_name = "test"
      security_group_desc = "Security Group fleettrackr host"
      vpc_id              = data.terraform_remote_state.sg.outputs.vpc_id

      ingress_with_cidr_blocks = [
        { from_port = 0, to_port = 0, protocol = "-1", description = "", cidr_blocks = "0.0.0.0/0" },
      ]

      egress_with_cidr_blocks = [
        { from_port = 0, to_port = 0, protocol = "-1", description = "", cidr_blocks = "0.0.0.0/0" },
      ]
    }
  ]
}


#module "ec2" {
#  source = "../../../modules//ec2/v0.41.0"
#
#
#}