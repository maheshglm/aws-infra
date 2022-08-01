output "ssm_write_ssm_name" {
  description = "The Parameter-Store SSM name."
  value       = aws_ssm_parameter.ssm.name
}

output "ssm_write_ssm_value" {
  description = "The Parameter-Store SSM value."
  value       = aws_ssm_parameter.ssm.value
  sensitive   = true
}

output "ssm_private_key_arn" {
  description = "The Paramter-Store SSM ARN."
  value       = aws_ssm_parameter.ssm.arn
}