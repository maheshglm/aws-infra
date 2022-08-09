output "dns_record" {
  description = "Route53 record name"
  value       = aws_route53_record.record.name
}

output "dns_fqdn" {
  description = "Route53 FQDN"
  value       = aws_route53_record.record.fqdn
}