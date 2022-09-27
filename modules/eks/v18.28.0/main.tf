locals {
  eks_cluster_name = format("%s-%s-%s", var.customer, var.project, var.environment)
  tags             = {
    customer_name = var.customer,
    project       = var.project,
    env           = var.environment, # environment tag key isn't allowed by AWS!
    unique_id     = var.unique_id,
    Name          = local.eks_cluster_name
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.28.0"

  cluster_version                 = var.eks_cluster_version
  cluster_name                    = local.eks_cluster_name
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_addons                  = var.cluster_addons
  vpc_id                          = var.eks_vpc_id
  subnet_ids                      = setunion(var.eks_private_subnets_ids, var.eks_public_subnets_ids)

  self_managed_node_group_defaults = var.self_managed_node_group_defaults
  self_managed_node_groups         = var.self_managed_node_groups
  eks_managed_node_group_defaults  = var.eks_managed_node_group_defaults
  eks_managed_node_groups          = var.eks_managed_node_groups

  enable_irsa               = var.enable_irsa
  manage_aws_auth_configmap = var.manage_aws_auth_configmap
  aws_auth_roles            = var.aws_auth_roles
  aws_auth_users            = var.aws_auth_users
  cluster_enabled_log_types = var.cluster_enabled_log_types

  iam_role_additional_policies         = var.iam_role_additional_policies
  node_security_group_additional_rules = var.node_security_group_additional_rules
  tags                                 = merge({
    Terraform = "true"
  },
  local.tags,
  var.additional_tags
  )
}