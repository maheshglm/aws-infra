output "lb_arn" {
  value       = module.lb.lb_arn
  description = "The ID and ARN of the load balancer we created."
}

output "lb_dns_name" {
  value       = module.lb.lb_dns_name
  description = "The DNS name of the load balancer."
}

output "target_group_arns" {
  value       = module.lb.target_group_arns
  description = "ARNs of the target groups. Useful for passing to your Auto Scaling group."
}

output "lb_id" {
  value       = module.lb.lb_id
  description = "The ID and ARN of the load balancer we created."
}

