output "registry_id" {
  description = "Registry ID"
  value       = module.ecr.registry_id
}

output "repository_arn" {
  description = "ARN of first repository created"
  value = module.ecr.repository_arn
}

output "repository_arn_map" {
  description = "Map of repository names to repository ARNs"
  value = module.ecr.repository_arn_map
}

output "repository_name" {
  description = "Name of first repository created"
  value = module.ecr.repository_name
}

output "repository_url" {
  description = "URL of first repository created"
  value = module.ecr.repository_url
}

output "repository_url_map" {
  description = "Map of repository names to repository URLs"
  value = module.ecr.repository_url_map
}