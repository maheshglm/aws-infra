locals {
  tags = {
    customer  = var.customer,
    project   = var.project,
    env       = var.environment
  }
}

module "security_group" {
  count = length(var.custom_security_groups)
  source = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name                     = var.custom_security_groups[count.index].security_group_name
  description              = var.custom_security_groups[count.index].security_group_desc
  vpc_id                   = var.custom_security_groups[count.index].vpc_id
  ingress_with_cidr_blocks = var.custom_security_groups[count.index].ingress_with_cidr_blocks
  egress_with_cidr_blocks  = var.custom_security_groups[count.index].egress_with_cidr_blocks

  tags = merge({
    Terraform = "true"
  },
  local.tags
  )


}


