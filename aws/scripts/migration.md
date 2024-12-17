# DO to AWS Migration

## Prerequisites
- AWS CLI configured with necessary permissions
- PostgreSQL client tools installed
- Access to both DO and AWS environments

## Configuration
Update the variables in the script:
```bash
SOURCE_DB_HOST="do-database-host"
SOURCE_DB_NAME="cbapp"
AWS_REGION="ap-south-1"
S3_BUCKET="cbapp-migration"
```

## Running Migration

1. **Database Migration**
```bash
./src/do-to-aws-migration.sh db
```

2. **Storage Migration**
```bash
./src/do-to-aws-migration.sh storage
```

3. **Full Migration**
```bash
./src/do-to-aws-migration.sh all
```

## Components Migrated
- PostgreSQL database
- DO Spaces to S3
- Basic configurations

## Verification
- Database restored successfully
- S3 storage synced
- Application can connect to new resources
