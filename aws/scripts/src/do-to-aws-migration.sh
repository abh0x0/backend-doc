#!/bin/bash
# Configuration
SOURCE_DB_HOST="do-database-host"
SOURCE_DB_NAME="cbapp"
SOURCE_DB_USER="user"
SOURCE_DB_PORT="5432"
AWS_REGION="ap-south-1"
S3_BUCKET="cbapp-migration"

# Logging
log() { echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $1"; }
error() { echo "[$(date +%Y-%m-%d\ %H:%M:%S)] ERROR: $1" >&2; }

# Database Migration
migrate_db() {
    log "Starting database migration..."

    # Create backup
    BACKUP_FILE="cbapp_$(date +%Y%m%d_%H%M%S).sql"
    log "Creating backup: $BACKUP_FILE"

    PGPASSWORD=$SOURCE_DB_PASSWORD pg_dump \
        -h $SOURCE_DB_HOST \
        -U $SOURCE_DB_USER \
        -p $SOURCE_DB_PORT \
        -d $SOURCE_DB_NAME \
        -F c -b -v -f $BACKUP_FILE || {
            error "Database backup failed"
            return 1
        }

    # Upload to S3
    log "Uploading backup to S3..."
    aws s3 cp $BACKUP_FILE s3://$S3_BUCKET/database-backups/ || {
        error "Upload to S3 failed"
        return 1
    }

    log "Database migration completed"
}

# Storage Migration
migrate_storage() {
    log "Starting storage migration..."

    # Sync DO Spaces to S3
    aws s3 sync s3://do-spaces-name s3://$S3_BUCKET/storage \
        --source-region nyc3 \
        --region $AWS_REGION || {
            error "Storage sync failed"
            return 1
        }

    log "Storage migration completed"
}

# Main
main() {
    case "$1" in
        "db")
            migrate_db
            ;;
        "storage")
            migrate_storage
            ;;
        "all")
            migrate_db && migrate_storage
            ;;
        *)
            echo "Usage: $0 {db|storage|all}"
            exit 1
            ;;
    esac
}

main "$@"
