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

variable "eks_vpc_id" {
  description = "VPC ID of the EKS Cluster to be provisioned into"
  type        = string
  default     = null
}

variable "eks_private_subnets_ids" {
  description = "EKS Cluster VPC private subnets IDs"
  type        = list(string)
  default     = []
}

variable "eks_public_subnets_ids" {
  description = "EKS Cluster VPC public subnets IDs"
  type        = list(string)
  default     = []
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "default"
}

variable "eks_cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
  default     = "1.20"
}

variable "cluster_endpoint_private_access" {
  type        = bool
  description = "Set to true to enable kubernetes private endpoint"
  default     = false
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  default     = true
}

variable "node_security_group_additional_rules" {
  description = " List of additional security group rules to add to the node security group created. Set `source_cluster_security_group = true` inside rules to set the `cluster_security_group` as source"
  type        = any
  default     = {}
}

variable "iam_role_additional_policies" {
  description = "Additional policies to be added to the IAM Role"
  type        = list(string)
  default     = []
}

variable "additional_tags" {
  description = "(Optional) A mapping of any arbitrary tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# IAM roles for service accounts
# https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html
variable "enable_irsa" {
  type        = bool
  description = "False if you don't want to enable IRSA for EKS"
  default     = true
}

# Managing users or IAM roles for your cluster
# https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
variable "manage_aws_auth_configmap" {
  type        = bool
  description = "Allow EKS module to manage aws-auth configmap (set to false if managed by external system. i.e GitOps)"
  default     = true
}

variable "aws_auth_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap. See examples/basic/variables.tf for example format."
  type        = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default     = []
}

variable "aws_auth_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type        = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default     = []
}

# Enable EKS Control Plane Logging to Cloudwatch.
# https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
variable "cluster_enabled_log_types" {
  description = "Cluster Control Plane logs to collect in Cloudwatch"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "cluster_addons" {
  description = "Map of cluster addon configurations to enable for the cluster. Addon name can be the map keys or set with name"
  type        = any
  default     = {}
}

variable "cluster_encryption_config" {
  description = "Configuration block with encryption configuration for the cluster"
  type        = list(any)
  default     = []
}

variable "self_managed_node_group_defaults" {
  description = "Map of self-managed node group default configurations"
  type        = any
  default     = {}
}

variable "self_managed_node_groups" {
  description = "Map of self-managed node group definitions to create"
  type        = any
  default     = {}
}

variable "eks_managed_node_group_defaults" {
  description = "Map of EKS managed node group default configurations"
  type        = any
  default     = {}
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions"
  type        = any
  default     = {}
}

