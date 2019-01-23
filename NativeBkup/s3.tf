resource "aws_s3_bucket" "b" {
  bucket = "sqlserver-backup.s.e"
  acl    = "private"

  tags = {
    Name        = "S3 bucket to backup SQLServer"
    Environment = "myfriendDEV"
  }
}

