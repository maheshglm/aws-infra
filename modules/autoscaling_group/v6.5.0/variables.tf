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

variable "min_size" {
  default = 0
  type = number
  description = "The minimum size of the autoscaling group"
}

variable "max_size" {
  default = 1
  type = number
  description = "The maximum size of the autoscaling group"
}

variable "desired_capacity" {
  default = 1
  type = number
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
}

