output "s3_bucket_bucket_domain_name" {
  value       = values(module.s3-bucket)[*].s3_bucket_bucket_domain_name
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
}

output "s3_bucket_id" {
  value       = values(module.s3-bucket)[*].s3_bucket_id
  description = "The name of the bucket."
}

output "s3_bucket_arn" {
  value       = values(module.s3-bucket)[*].s3_bucket_arn
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
}

output "s3_bucket_region" {
  value       = values(module.s3-bucket)[*].s3_bucket_region
  description = "The region of the buckets."
}