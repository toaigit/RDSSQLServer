#   grant execute on the backup and restore procedure to someone

use msdb
GRANT EXECUTE ON dbo.rds_backup_database to scotty
GRANT EXECUTE ON dbo.rds_restore_database to scotty

#  As db.owner you can run backup
exec msdb.dbo.rds_backup_database 
        @source_db_name='toaivodb', 
        @s3_arn_to_backup_to='arn:aws:s3:::sqlserver-backup.s.e/frienddb.bak',
        @overwrite_S3_backup_file=1,
        @type='FULL';

#  Restore DB  as the user with ability to create db
exec msdb.dbo.rds_restore_database
@restore_db_name='frienddbBK',
@s3_arn_to_restore_from='arn:aws:s3:::sqlserver-backup.s.e/frienddb.bak';

