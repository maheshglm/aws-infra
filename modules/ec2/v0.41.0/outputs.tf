output "id" {
  description = "The ID of the instance"
  value       = module.ec2.id
}

output "arn" {
  description = "The ARN of the instance"
  value       = module.ec2.arn
}

output "private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = module.ec2.private_dns
}

output "public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = module.ec2.public_dns
}

output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = module.ec2.public_ip
}

output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = module.ec2.private_ip
}

output "instance_name" {
  description = "EC2 Instance name."
  value       = var.name
}