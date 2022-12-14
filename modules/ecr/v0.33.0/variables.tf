variable "name" {
  description = "Name of the EC2 instance to be used on as identifier"
  type        = string
  default     = "defaultName"
}

variable "customer" {
  description = "Name of the customer to be used on all the resources as identifier"
  type        = string
  default     = "defaultCustomer"
}

variable "project" {
  description = "Name of the project to be used on all the resources as identifier"
  type        = string
  default     = "defaultProject"
}

variable "environment" {
  description = "Name of the environment to be used on all the resources as identifier"
  type        = string
  default     = "defaultEnvironment"
}

variable "delimiter" {
  description = "Delimiter to be used between ID elements."
  type        = string
  default     = "-"
}

variable "enable_lifecycle_policy" {
  description = "To enable lifecycle policies on any repositories"
  type        = bool
  default     = true
}

variable "enabled" {
  description = "Allow the module from creating any resources, false is to prevent"
  type        = bool
  default     = false
}

variable "image_names" {
  description = "List of Docker local image names, used as repository names for AWS ECR"
  type        = list(string)
  default     = []
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE"
  type        = string
  default     = "IMMUTABLE"
}

variable "label_key_case" {
  description = "Controls the letter case of the tags keys (label names) for tags generated by this module"
  type        = string
  default     = null
}

variable "max_image_count" {
  description = "Number of Docker Image versions AWS ECR will store"
  type        = number
  default     = 500
}

variable "principals_full_access" {
  description = "Principal ARNs to provide with full access to the ECR"
  type        = list(string)
  default     = []
}

variable "principals_lambda" {
  description = "Principal account IDs of Lambdas allowed to consume ECR"
  type        = list(string)
  default     = []
}

variable "principals_readonly_access" {
  description = "Principal ARNs to provide with readonly access to the ECR"
  type        = list(string)
  default     = []
}

variable "protected_tags" {
  description = "Name of image tags prefixes that should not be destroyed. Useful if you tag images with names like dev, staging, and prod"
  type        = list(string)
  default     = []
}

variable "scan_images_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not (false)"
  type        = bool
  default     = true
}

variable "encryption_configuration" {
  type        = object({
    encryption_type = string
    kms_key         = any
  })
  description = "ECR encryption configuration"
  default     = null
}