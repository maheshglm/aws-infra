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
#  custom_security_groups = [
#  {
#    security_group_name      = "${local.name_prefix}-wordpress-ec2-sg"
#    security_group_desc      = "Security Group for Wordpress Autoscaling group"
#    vpc_id                   = dependency.vpc.outputs.vpc_id
#    ingress_with_cidr_blocks = [
#      { from_port = 443, to_port = 443, protocol = "tcp", description = "Https traffic", cidr_blocks = "0.0.0.0/0" },
#      { from_port = 22, to_port = 22, protocol = "tcp", description = "ssh access", cidr_blocks = "0.0.0.0/0" },
#      { from_port = 80, to_port = 80, protocol = "tcp", description = "Http traffic", cidr_blocks = "0.0.0.0/0" },
#    ]
#    egress_with_cidr_blocks  = [
#      { from_port = 0, to_port = 0, protocol = "-1", description = "", cidr_blocks = "0.0.0.0/0" },
#    ]
#  }
#]
}