// Environment name, used as prefix to name resources.
variable "environment" {
   default = "airprintdev"
   }

// The allocated storage in gigabytes.
variable "rds_allocated_storage" {
  default = "25"
}

// The instance type of the RDS instance.
variable "rds_instance_class" {
  default = "db.t2.small"
}
variable "engine" {
  default = "sqlserver-ex"
}
variable "engine_version" {
  default = "13.00.5216.0.v1"
}

variable "parameter_group_name" {
  default = "default.sqlserver-ex-13.0"
}

variable "option_group_name" {
  default = "default:sqlserver-ex-13-00"
}

// Specifies if the RDS instance is multi-AZ.
variable "rds_multi_az" {
  default = "false"
}

// Username for the administrator DB user.
variable "mssql_admin_username" {
    default = "poweruser"
    }

// Password for the administrator DB user.
variable "mssql_admin_password" {
    default = "your-long-secure-password"
    }

// A list of VPC subnet identifiers.
variable "vpc_subnet_ids" {
  type = "list"
  default = ["subnet-a78150fc","subnet-caade283","subnet-d47740b3"]
}

// The VPC identifier where security groups are going to be applied.
variable "vpc_id" {
   default = "vpc-f8ccd79f"
   }

// List of CIDR blocks that will be granted to access to mssql instance.
variable "vpc_cidr_blocks" {
  type    = "list"
  default = ["14.28.109.35/32","10.2.48.0/20","10.2.96.0/20"]
}

// Determines whether a final DB snapshot is created before the DB instance is deleted.
variable "skip_final_snapshot" {
  type    = "string"
  default = "false"
}

variable "db_name" {
  type    = "string"
  default = "testInst"
}

variable "creator" {
  type    = "string"
  default = "your-name"
}

variable "db_port" {
  default = 1433
}

variable "backup_retention" {
  default = 3
}

variable "delete_protection" {
  default = "false"
}

variable "publicly_accessible" {
  default = "true"
}

variable "timezone" {
  default = "Pacific Standard Time"
}

variable "sns_topic_arn" {
  default = "arn:aws:sns:us-west-2:397926941813:SNS-Topic-AlertToai"
}

variable "rds_event_name" {
  default = "DBInstance-Monitoring-PageToai"
}

