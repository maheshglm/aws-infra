
module "vpc" {
  source      = "../../../modules//vpc/v3.14.2"
  customer    = var.customer_name
  environment = var.environment

  cidr             = var.cidr
  private_subnets  = var.private_subnets
  public_subnets   = var.public_subnets
  database_subnets = var.database_subnets

  enable_nat_gateway   = true
  enable_vpn_gateway   = true
  enable_dns_support   = true
  enable_dns_hostnames = true
  single_nat_gateway   = true
}