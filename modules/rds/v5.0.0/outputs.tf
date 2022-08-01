output "service_endpoint_single" {
  value = module.db.db_instance_endpoint
}

output "db_instance_password" {
  value     = module.db.db_instance_password
  sensitive = true
}

output "db_instance_name" {
  value = module.db.db_instance_name
}

output "db_instance_username" {
  value = module.db.db_instance_username
  sensitive = true
}

output "db_instance_status" {
  value = module.db.db_instance_status
}