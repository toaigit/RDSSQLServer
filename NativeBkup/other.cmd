
#Create a snapshot backup
create-db-snapshot --db-snapshot-identifier <enter-a-desc> --db-instance-identifier <value>

# List all the backup snapshot 
aws rds describe-db-snapshots --query="DBSnapshots[*].[DBSnapshotIdentifier,SnapshotCreateTime,SnapshotType]" 

# How to get the Supported Version to put in the terraform
aws rds describe-db-engine-versions --query="DBEngineVersions[*].[DBEngineVersionDescription]" --output=text | grep "SQL Server"

