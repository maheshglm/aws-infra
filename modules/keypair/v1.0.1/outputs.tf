output "key_name" {
  description = "The key pair name."
  value       = module.key_pair.key_pair_key_name
}

output "key_pair_id" {
  description = "The key pair ID."
  value       = module.key_pair.key_pair_key_pair_id
}

output "public_key" {
  description = "The public key."
  value       = tls_private_key.this.public_key_openssh
}

output "private_key" {
  description = "The private key."
  value       = tls_private_key.this.private_key_pem
  sensitive   = true
}

output "ssm_private_key_name" {
  description = "The Paramter-Store SSM private key name."
  value       = aws_ssm_parameter.private_key.name
}

output "ssm_private_key_arn" {
  description = "The Paramter-Store SSM private key ARN."
  value       = aws_ssm_parameter.private_key.arn
}