data "aws_availability_zones" "available" {}

locals {
  azs     = data.aws_availability_zones.available.names
  tags = {
    customer  = var.customer,
    project   = var.project,
    env       = var.environment
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v3.14.2"

  name                              = format("%s-%s-%s", var.customer, var.project, var.environment)
  cidr                              = var.cidr
  azs                               = data.aws_availability_zones.available.names
  private_subnets                   = var.private_subnets
  public_subnets                    = var.public_subnets
  database_subnets                  = var.database_subnets
  enable_vpn_gateway                = var.enable_vpn_gateway
  enable_dns_support                = var.enable_dns_support
  enable_dns_hostnames              = var.enable_dns_hostnames
  create_database_subnet_group      = var.create_database_subnet_group

  enable_nat_gateway     =  var.enable_nat_gateway
  single_nat_gateway     =  var.single_nat_gateway
  one_nat_gateway_per_az =  var.one_nat_gateway_per_az

  default_vpc_tags = merge({
    Terraform = "true"
  },
  local.tags
  )
}