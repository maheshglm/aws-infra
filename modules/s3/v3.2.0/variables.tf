variable "customer_name" {
  description = "Name of the customer to be used on all the resources as identifier"
  default     = "defaultCustomer"
  type        = string
}

variable "project" {
  description = "Name of the project to be used on all the resources as identifier"
  default     = "defaultProject"
  type        = string
}

variable "environment" {
  description = "Name of the environment to be used on all the resources as identifier"
  default     = "defaultEnvironment"
  type        = string
}

variable "unique_id" {
  type    = string
  default = "00000"
}

variable "acl" {
  type        = string
  default     = "private"
  description = "(Optional) The canned ACL to apply. Defaults to 'private'. Conflicts with `grant`"
}

variable "s3_bucket_list" {
  type        = map(any)
  description = "The list of bucket name with format <bucket_purpose> = <bucket_name>, pelase use key format like mentioned in default value"
}

variable "restrict_public_buckets" {
  type        = bool
  default     = true
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
}

variable "block_public_acls" {
  type        = bool
  default     = true
  description = "Whether Amazon S3 should block public ACLs for this bucket."
}

variable "block_public_policy" {
  type        = bool
  default     = true
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
}

variable "ignore_public_acls" {
  type        = bool
  default     = true
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
}

variable "policy" {
  type        = string
  default     = null
  description = "A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
}

variable "attach_policy" {
  type        = bool
  default     = false
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
}

variable "cors_rule" {
  type        = any
  default     = []
  description = "List of maps containing rules for Cross-Origin Resource Sharing."
}

variable "lifecycle_rule" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default     = []
}

variable "logging" {
  description = "Map containing access bucket logging configuration."
  type        = map(string)
  default     = {}
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "additional_tags" {
  description = "(Optional) A mapping of any arbitrary tags to assign to the resource."
  type        = map(string)
  default     = {}
}