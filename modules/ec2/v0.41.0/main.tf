locals {
  tags = {
    customer_name = var.customer,
    project       = var.project,
    env           = var.environment, # environment tag key isn't allowed by AWS!
    unique_id     = var.unique_id,
  }
}

module "ec2" {
  source  = "cloudposse/ec2-instance/aws"
  version = "0.41.0"

  # Base Configurations.
  name                        = var.name
  instance_type               = var.instance_type
  ssh_key_pair                = var.ssh_key_pair
  vpc_id                      = var.vpc_id
  security_groups             = var.security_groups
  subnet                      = var.subnet
  ami                         = var.ami
  ami_owner                   = var.ami_owner
  root_volume_type            = var.root_volume_type
  root_volume_size            = var.root_volume_size
  root_iops                   = var.root_iops
  root_block_device_encrypted = var.root_block_device_encrypted
  kms_key_id                  = var.kms_key_id
  delete_on_termination       = var.delete_on_termination

  # User Data Configurations.
  user_data_base64 = sensitive(var.user_data_base64)

  # Permissions Configurations.
  instance_profile = var.instance_profile

  # Networking Configurations.
  associate_public_ip_address = var.associate_public_ip_address
  source_dest_check           = var.source_dest_check
  assign_eip_address          = var.assign_eip_address

  # Additional Storage Configurations.
  ebs_volume_count     = var.ebs_volume_count
  ebs_volume_type      = var.ebs_volume_type
  ebs_volume_size      = var.ebs_volume_size
  ebs_volume_encrypted = var.ebs_volume_encrypted
  ebs_iops             = var.ebs_iops
  ebs_optimized        = var.ebs_optimized

  # Monitoring Configurations.
  monitoring = var.monitoring

  # Updating tags
  tags = local.tags
}