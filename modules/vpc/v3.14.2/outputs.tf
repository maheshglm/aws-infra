# AZs
output "azs" {
  value       = module.vpc.azs
  description = "AZ discovered names"
}

# VPC outputs.
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID created"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "Private subnets IDs"
}

output "private_subnets_cidr_blocks" {
  value       = module.vpc.private_subnets_cidr_blocks
  description = "Private subnets CIDRs"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "Public subnets IDs"
}

output "public_subnets_cidr_blocks" {
  value       = module.vpc.public_subnets_cidr_blocks
  description = "Public subnets CIDRs"
}

output "natgw_ids" {
  value       = module.vpc.natgw_ids
  description = "NAT Gateways IDs"
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "CIDR Block"
}