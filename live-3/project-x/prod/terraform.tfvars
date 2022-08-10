# Account level variables
account_name          = "mahesh-prod"
aws_account_id        = "471871787162"
main_domain_zone_name = "letsdevops.link"
main_domain_zone_id   = "Z07545101ST1W7S7CWAJI"

# Customer level variables
customer_name = "mahesh"

# region level variables
aws_region = "us-east-2"

# environment related variables
environment                  = "prod"
environment_domain_zone_name = "prod.letsdevops.link"

acm_cert_arn = "arn:aws:acm:us-east-2:471871787162:certificate/06a8f8c8-96af-4278-934e-a8a3e9d1200f"


# vpc variables

cidr = "10.0.0.0/16"

private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets   = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
database_subnets = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]