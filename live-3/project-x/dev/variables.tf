variable "account_name" {}
variable "aws_account_id" {}
variable "main_domain_zone_name" {}
variable "main_domain_zone_id" {}
variable "customer_name" {}
variable "aws_region" {}
variable "environment" {}
variable "environment_domain_zone_name" {}
variable "acm_cert_arn" {}
variable "cidr" {}
variable "private_subnets" {}
variable "public_subnets" {}
variable "database_subnets" {}

variable "project_name" {
  type    = string
  default = "wordpress"
}
