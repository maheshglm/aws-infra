variable "customer_name" {
  type        = string
  description = "Our Valuable Customer Name"
}

variable "environment" {
  type        = string
  description = "Our Standard Environment to be used (ex dev / prod)"
}

variable "unique_id" {
  type        = string
  description = "Our Standard Unique ID to be used (ex 001 / 101 / 111)"
}

variable "project" {
  type        = string
  default     = "defaultProject"
  description = "Our Standard Project to be used (ex myDefaultProject)"
}

variable "iam_user_name" {
  type        = string
  description = "The user's name."
}

variable "iam_user_path" {
  type        = string
  default     = "/"
  description = "Path in which to create the user."
}

variable "create_iam_user_login_profile" {
  type        = bool
  default     = true
  description = "Whether to create IAM user login profile"
}

variable "create_user" {
  type        = bool
  default     = true
  description = "Whether to create the IAM user"
}

variable "create_iam_access_key" {
  type        = bool
  default     = true
  description = "Whether to create IAM access key"
}

variable "permissions_boundary" {
  type        = string
  description = "The ARN of the policy that is used to set the permissions boundary for the user"
  default     = ""
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed"
}

variable "password_reset_required" {
  type        = bool
  default     = false
  description = "Whether the user should be forced to reset the generated password on first login"
}


variable "iam_policy_arn" {
  type        = string
  description = "The ARN of the policy to attach to this user"
  default     = ""
}