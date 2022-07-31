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

variable "custom_security_groups" {
  description = "List of user specified security groups"
  type        = any
  default     = []
}