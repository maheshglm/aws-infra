output "iam_user_name" {
  value       = module.iam_user.iam_user_name
  description = "Restricted AWS IAM Role ARN"
}

output "iam_user_arn" {
  value       = module.iam_user.iam_user_arn
  description = "Restricted AWS IAM Role ARN"
}

output "iam_access_key_id" {
  value       = module.iam_user.iam_access_key_id
  description = "The access key ID"
}

output "iam_access_key_secret" {
  value       = module.iam_user.iam_access_key_secret
  description = "The access key secret"
  sensitive   = true
}