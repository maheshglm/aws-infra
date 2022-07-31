output "security_group_description" {
  description = "List of security group descriptions"
  value       = module.security_group[*].security_group_description
}

output "security_group_ids" {
  description = "List of security group IDs"
  value       = module.security_group[*].security_group_id
}

output "security_group_names" {
  description = "List of security group names"
  value       = module.security_group[*].security_group_name
}

output "security_group_owner_ids" {
  description = "List of security group owner IDs"
  value       = module.security_group[*].security_group_owner_id
}

output "security_group_vpc_ids" {
  description = "List of security group VPC_IDs"
  value       = module.security_group[*].security_group_vpc_id
}