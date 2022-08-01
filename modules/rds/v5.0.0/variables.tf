variable "customer_name" {
  type    = string
}

variable "project" {
  type    = string
  default = "defaultProject"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "unique_id" {
  type    = string
  default = "001"
}

variable "service_group" {
  type        = string
  description = "Name identifier for service"
  default     = "defaultservicegroup"
}

variable "rds_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = "25"
}

variable "rds_db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = null
}

variable "rds_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not."
  type        = string
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = false
}
variable "rds_engine" {
  description = "The database engine to use"
  type        = string
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "12.7"
}

variable "rds_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t2.micro"
}

variable "rds_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "smartcow"
}

variable "rds_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  default     = ""
}

variable "rds_port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = 5432
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "VPC Id to associate"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "VPC Id to associate"
  type        = list(string)
}

variable "availability_zone" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  type        = string
  default     = null
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
  type        = string
  default     = "rds-monitoring-role"
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = "7"
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "03:00-06:00"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}

variable "options" {
  description = "A list of Options to apply."
  type        = any
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "max_rds_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 0
}

variable "create_auth_token" {
  description = "Whether to create random password for RDS primary cluster"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance"
  type        = bool
  default     = false
}

variable "ssm_rds_username_path" {
  description = "ssm Key for rds username"
  type        = string
  default     = "rds_username"
}

variable "ssm_rds_password_path" {
  description = "ssm Key for rds password"
  type        = string
  default     = "rds_password"
}

variable "kms_key_id" {
  type        = string
  description = "The ARN for the KMS encryption key. When specifying `kms_key_id`, `storage_encrypted` needs to be set to `true`"
  default     = null
}

variable "additional_tags" {
  description = "(Optional) A mapping of any arbitrary tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs."
  type        = list(string)
  default     =  []
}

variable "create_cloudwatch_log_group" {
  description = "Determines whether a CloudWatch log group is created for each enabled_cloudwatch_logs_exports"
  type        = bool
  default     = false
}

variable "parameters" {
  description = "A list of DB parameters (map) to apply"
  type        = list(map(string))
  default     = []
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled"
  type        = bool
  default     = false
}

variable "create_random_password" {
  description = "Whether to create random password for RDS primary cluster"
  type        = bool
  default     = false
}

variable "major_engine_version" {
  type = string
  default = ""
}
