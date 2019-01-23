resource "aws_db_subnet_group" "default_rds_mssql" {
  name        = "${var.environment}-rds-mssql-sg"
  description = "The ${var.environment} rds-mssql sg"
  subnet_ids  = ["${var.vpc_subnet_ids}"]

  tags {
    Name = "${var.environment}-rds-mssql-subnet-group"
    Env  = "${var.environment}"
  }
}

resource "aws_security_group" "rds_mssql_security_group" {
  name        = "${var.environment}-rds-mssql-sg"
  description = "${var.environment} allow traffic to rds mssql."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${var.db_port}"
    to_port     = "${var.db_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_blocks}"]
  }

  tags {
    Name = "${var.environment}-rds-mssql-sg"
    Env  = "${var.environment}"
  }
}

resource "aws_db_instance" "myDBInstance" {
  depends_on                = ["aws_db_subnet_group.default_rds_mssql"]
  identifier                = "${var.environment}-mssql"
  allocated_storage         = "${var.rds_allocated_storage}"
  license_model             = "license-included"
  storage_type              = "gp2"
  engine                    = "${var.engine}"
  engine_version            = "${var.engine_version}"
  instance_class            = "${var.rds_instance_class}"
  multi_az                  = "${var.rds_multi_az}"
  username                  = "${var.mssql_admin_username}"
  password                  = "${var.mssql_admin_password}"
  vpc_security_group_ids    = ["${aws_security_group.rds_mssql_security_group.id}"]
  db_subnet_group_name      = "${aws_db_subnet_group.default_rds_mssql.id}"
  option_group_name         = "${var.option_group_name}"
  parameter_group_name      = "${var.parameter_group_name}"
  backup_retention_period   = "${var.backup_retention}"
  skip_final_snapshot       = "${var.skip_final_snapshot}"
  final_snapshot_identifier = "${var.environment}-mssql-final-snapshot"
  deletion_protection       = "${var.delete_protection}"
  timezone                  = "${var.timezone}"
  publicly_accessible       = "${var.publicly_accessible}"
  port                      = "${var.db_port}"
  tags = {
      Creator = "${var.creator}"
      Environment = "${var.environment}"
      }
}

resource "aws_db_event_subscription" "myEvent" {
  name      = "${var.rds_event_name}"
  sns_topic = "${var.sns_topic_arn}"

  source_type = "db-instance"
  source_ids  = ["${aws_db_instance.myDBInstance.id}"]

  event_categories = [
    "availability",
    "deletion",
    "failover",
    "failure",
    "low storage",
    "maintenance",
    "notification",
    "read replica",
    "recovery",
    "restoration",
  ]
}

// Identifier of the mssql DB instance.
output "mssql_id" {
  value = "${aws_db_instance.myDBInstance.id}"
}

// Address of the mssql DB instance.
output "mssql_address" {
  value = "${aws_db_instance.myDBInstance.address}"
}
