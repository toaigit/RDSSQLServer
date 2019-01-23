#!/bin/sh
# create a new Option Group
aws rds create-option-group \
     --option-group-name SQLserverOptionGroup \
     --engine-name sqlserver-ex \
     --major-engine-version 13.00 \
     --option-group-description "Native Backup option group for RDS"

#  Enable SQLSERVER_BACKUP_RESTORE
aws rds add-option-to-option-group \
     --option-group-name SQLserverOptionGroup \
     --apply-immediately  \
     --options "OptionName=SQLSERVER_BACKUP_RESTORE,OptionSettings=[{Name=IAM_ROLE_ARN,Value=arn:aws:iam::324836732198:role/service-role/sqlNativeBackupRole}]"

#  Associate the DBInstance with this new Option Group
aws rds modify-db-instance --db-instance-identifier mySQLServerdev --option-group-name SQLserverOptionGroup

