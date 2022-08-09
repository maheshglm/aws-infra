variable "zone_id" {
  description = "DNS Zone ID"
  type        = string
}

variable "name" {
  description = "DNS Record Name"
  type        = string
}

variable "type" {
  description = "DNS Record Type"
  type        = string
  default     = "A"
}

variable "ttl" {
  description = "DNS Record TTL"
  type        = number
  default     = 300
}

variable "records" {
  description = "DNS Record values"
  type        = list(string)
}