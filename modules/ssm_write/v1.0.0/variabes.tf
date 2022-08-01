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

variable "resource" {
  type        = string
  description = "The resource name"
  default     = "defaultResource"

}

variable "ssm_name" {
  type        = string
  description = "The ssm name"
}

variable "service" {
  type        = string
  description = "The ssm name"
  default     = "defaultService"
}

variable "unique_id" {
  description = "Unique ID to be used on all the resources as identifier"
  type        = string
  default     = "00000"
}

variable "ssm_value" {
  description = "ssm value"
  type        = string
  default     = "defaultValue"
}

variable "overwrite" {
  description = "overwrite if there is existing ssm variable with same name"
  type        = bool
  default     = false
}

variable "type" {
  description = "type of the variable, String or SecureString"
  type        = string
  default     = "String"
}

variable "description" {
  description = "ssm variable description"
  type        = string
  default     = ""
}