output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks.cluster_arn
}

output "cluster_id" {
  description = "The name/id of the EKS cluster"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API"
  value       = module.eks.cluster_endpoint
}

output "cluster_token" {
  description = "The token for your EKS Kubernetes API"
  value       = data.aws_eks_cluster_auth.cluster.token
  sensitive   = true
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.eks.cluster_oidc_issuer_url
}

output "cluster_primary_security_group_id" {
  description = "The cluster primary security group ID created by the EKS cluster"
  value       = module.eks.cluster_primary_security_group_id
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster"
  value       = module.eks.cluster_version
}

output "eks_managed_node_groups" {
  description = "Outputs from EKS managed node groups. Map of attribute maps for all EKS managed node groups created"
  value       = module.eks.eks_managed_node_groups
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
  value       = module.eks.oidc_provider_arn
}

// output "worker_iam_role_arn" {
//   description = "default IAM role ARN for EKS worker groups"
//   value       = module.eks.worker_iam_role_arn
// }

output "node_security_group_id" {
  description = "Shared Security group ID attached to the EKS nodes"
  value       = module.eks.node_security_group_id
}

output "eks_managed_node_groups_autoscaling_group_names" {
  description = " List of the autoscaling group names created by EKS managed node groups"
  value       = module.eks.eks_managed_node_groups_autoscaling_group_names
}

// output "workers_asg_names" {
//   description = "Names of the autoscaling groups containing workers"
//   value       = module.eks.workers_asg_names
// }

// output "workers_default_ami_id" {
//   description = "ID of the default worker group AMI"
//   value       = module.eks.workers_default_ami_id
// }

output "cluster_certificate_authority_data" {
  description = "Certificate Authority data for your cluster. base64 encoded"
  value       = module.eks.cluster_certificate_authority_data
}
