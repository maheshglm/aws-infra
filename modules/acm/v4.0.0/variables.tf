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

variable "unique_id" {
  description = "Unique ID to be used on all the resources as identifier"
  type        = string
  default     = "00000"
}

variable "domain_name" {
  type        = string
  description = "A domain name for the certificate to be issued"
}

variable "zone_id" {
  type        = string
  description = "The ID of the hosted zone of the acm_domain."
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "A list of SANs that should be included in the certificate"
}

variable "validation_method" {
  type        = string
  default     = "DNS"
  description = "Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
}

variable "validate_certificate" {
  type        = bool
  default     = true
  description = "Whether to validate certificate by creating Route53 record"
}

variable "validation_allow_overwrite_records" {
  type        = bool
  default     = true
  description = "Whether to allow overwrite of Route53 records	"
}

variable "create_certificate" {
  type        = bool
  default     = true
  description = "Whether to create ACM certificate	 "
}



