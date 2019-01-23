resource "aws_iam_role" "sqlNativeBackupRole" {
  name = "sqlNativeBackupRole"
  path = "/service-role/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "rds.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "sqlNativeBackup-TAG"
  }
}

resource "aws_iam_role_policy_attachment" "attach-sqlNativeBackup" {
  role       = "${aws_iam_role.sqlNativeBackupRole.name}"
  policy_arn = "${aws_iam_policy.sqlNativeBackupPolicy.arn}"
}

resource "aws_iam_policy" "sqlNativeBackupPolicy" {
  name        = "sqlNativeBackupPolicy"
  path        = "/service-role/"
  description = "RDS Native Backup policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:aws:s3:::sqlserver-backup.s.e"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObjectMetaData",
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload"
            ],
            "Resource": [
                "arn:aws:s3:::sqlserver-backup.s.e/*"
            ]
        }
    ]
}
EOF
}
