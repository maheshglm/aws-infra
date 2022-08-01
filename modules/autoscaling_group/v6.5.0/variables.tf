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
  default     = 0
  type        = number
  description = "The minimum size of the autoscaling group"
}

variable "max_size" {
  default     = 1
  type        = number
  description = "The maximum size of the autoscaling group"
}

variable "desired_capacity" {
  default     = 1
  type        = number
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
}

variable "health_check_type" {
  default     = "EC2"
  type        = string
  description = "EC2 or ELB. Controls how health checking is done"
}

variable "vpc_zone_identifier" {
  default     = null
  type        = list(string)
  description = "A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside"
}

variable "use_name_prefix" {
  default = true
  type    = bool
}

variable "target_group_arns" {
  default     = null
  type        = list(string)
  description = "A set of aws_alb_target_group ARNs, for use with Application or Network Load Balancing"
}

variable "image_id" {
  default     = ""
  type        = string
  description = "The AMI from which to launch the instance"
}

variable "instance_type" {
  default     = null
  type        = string
  description = "The type of the instance If present then instance_requirements cannot be present"
}

variable "user_data" {
  default     = null
  type        = string
  description = "user data to provide when launching the instance"
}

variable "security_groups" {
  default     = []
  type        = list(string)
  description = "A list of security group IDs to associate"
}

variable "key_name" {
  default     = null
  type        = string
  description = "The key name that should be used for the instance"
}



