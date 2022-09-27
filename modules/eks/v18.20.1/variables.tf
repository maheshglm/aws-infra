variable "aws_region" {
  description = "name of the aws region"
  type        = string
  default     = ""
}

variable "aws_account_id" {
  description = "The ID of the AWS account"
  type        = string
  default     = ""
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

variable "unique_id" {
  description = "Unique ID to be used on all the resources as identifier"
  type        = string
  default     = "00000"
}


variable "eks_vpc_id" {
  description = "VPC ID of the EKS Cluster to be provisioned into"
  type        = string
  default     = ""
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

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions"
  type        = any
  default     = {}
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
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "aws_auth_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

# Enable EKS Control Plane Logging to Cloudwatch.
# https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
variable "cluster_enabled_log_types" {
  description = "Cluster Control Plane logs to collect in Cloudwatch"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "enable_vpc_cni" {
  type        = bool
  description = "Enable AWS VPC CNI Plugin"
  default     = false
}

variable "vpc_cni_namespace" {
  type        = string
  description = "Name of AWS VPC CNI namespace"
  default     = "kube-system"
}

variable "vpc_cni_serviceaccount" {
  type        = string
  description = "Name of AWS VPC CNI Service Account"
  default     = "aws-node"
}

# Enable AWS Load Balancer Controller, LBC. a.k.a: ALB via IRSA
# https://aws.amazon.com/blogs/opensource/kubernetes-ingress-aws-alb-ingress-controller/
# https://aws.amazon.com/blogs/opensource/introducing-fine-grained-iam-roles-service-accounts/
# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.1/deploy/installation/
variable "enable_load_balancer_controller" {
  type        = bool
  description = "Enable AWS Loadbalancer Controller IRSA"
  default     = false
}

# This is the default value defined in AWS LBC v2.1 manifests.
# Changing this value, requires changing it in the yaml manifests as well.
variable "load_balancer_controller_namespace" {
  type        = string
  description = "Name of AWS Loadbalancer Controller namespace"
  default     = "kube-system"
}

# This is the default value defined in AWS LBC v2.1 manifests.
# Changing this value, requires changing it in the yaml manifests as well.
variable "load_balancer_controller_serviceaccount" {
  type        = string
  description = "Name of Loadbalancer Controller Service Account"
  default     = "aws-load-balancer-controller"
}

# Enable AWS External DNS Controller via IRSA.
variable "enable_external_dns_controller" {
  type        = bool
  description = "Enable AWS External DNS Controller IRSA"
  default     = false
}

variable "external_dns_controller_namespace" {
  type        = string
  description = "Name of AWS External DNS Controller namespace"
  default     = "kube-system"
}

variable "external_dns_controller_serviceaccount" {
  type        = string
  description = "Name of External DNS Controller Service Account"
  default     = "external-dns"
}

# Enable Cloudwatch exporter Role and Policy via IRSA.
variable "enable_cloudwatch_exporter" {
  type        = bool
  description = "Enable Cloudwatch exporter IRSA Role and Policy"
  default     = false
}

variable "cloudwatch_exporter_namespace" {
  description = "Cloudwatch exporter namespace"
  type        = string
  default     = "monitoring"
}

variable "cloudwatch_exporter_serviceaccount" {
  description = "Cloudwatch exporter Service Account name"
  type        = string
  default     = "cloudwatch-exporter"
}

# Enable External Secrets controller Role and Policy via IRSA.
variable "enable_external_secrets" {
  type        = bool
  description = "True to enable the ExternalSecrets role for EKS"
  default     = false
}

variable "external_secrets_namespace" {
  type        = string
  description = "Name of the ExternalSecrets namespace"
  default     = "kube-system"
}

variable "external_secrets_serviceaccount" {
  type        = string
  description = "Name of the ExternalSecrets service account"
  default     = "external-secrets"
}

# Enable Cluster Autoscaler controller Role and Policy via IRSA.
# https://docs.aws.amazon.com/eks/latest/userguide/cluster-autoscaler.html
variable "enable_cluster_autoscaler" {
  type        = bool
  description = "Enable Cluster Autoscaler IRSA Role and Policy"
  default     = false
}

variable "cluster_autoscaler_namespace" {
  description = "Cluster Autoscaler namespace"
  type        = string
  default     = "kube-system"
}

variable "cluster_autoscaler_serviceaccount" {
  description = "Cluster Autoscaler Service Account name"
  type        = string
  default     = "cluster-autoscaler"
}

# Enable EBS CSI Driver Role and Policy via IRSA.
# https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html
# https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/v1.1.0/docs/example-iam-policy.json
variable "enable_ebs_csi_driver" {
  type        = bool
  description = "Enable EBS CSI Driver IRSA Role and Policy"
  default     = false
}

variable "ebs_csi_driver_namespace" {
  description = "EBS CSI Driver namespace"
  type        = string
  default     = "kube-system"
}

variable "ebs_csi_driver_serviceaccount" {
  description = "EBS CSI Driver Service Account name"
  type        = string
  default     = "ebs-csi-driver"
}

# Enable ECR Read Only policy via IRSA.
# Required for Flux image update controller to access ECR repo tags.
# https://fluxcd.io/docs/guides/image-update/
variable "enable_ecr_ro" {
  type        = bool
  description = "Enable ECR Read Only IRSA Role and Policy"
  default     = false
}

variable "ecr_ro_namespace" {
  description = "ECR Read only IRSA namespace (used by GitOps controllers / Jobs)"
  type        = string
  default     = "flux-system"
}

variable "ecr_ro_serviceaccount" {
  description = "ECR Read Only IRSA service account used by ecr-credentials sync cron job in GitOps namespace"
  type        = string
  default     = "ecr-credentials-sync"
}