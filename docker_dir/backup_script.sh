#!/bin/bash

help () {
    echo "Specify the following in the environment:"
    echo "AWS_ACCESS_KEY_ID"
    echo "AWS_SECRET_ACCESS_KEY"
    echo "AWS_STORAGE_BUCKET_NAME"
    echo "AWS_S3_REGION_NAME"
    echo "DATABASE_SERVER"
    echo "DATABASE_USER"
    echo "DATABASE_PASSWORD"
    echo "BACKUP_BASE"
    exit 1
}

if [[ "$AWS_ACCESS_KEY_ID" == "" ]]; then
    echo "No AWS_ACCESS_KEY_ID specified"
    help
fi

if [[ "$AWS_SECRET_ACCESS_KEY" == "" ]]; then
    echo "No AWS_SECRET_ACCESS_KEY specified"
    help
fi

if [[ "$AWS_STORAGE_BUCKET_NAME" == "" ]]; then
    echo "No AWS_STORAGE_BUCKET_NAME specified"
    help
fi

if [[ "$AWS_S3_REGION_NAME" == "" ]]; then
    echo "No AWS_S3_REGION_NAME specified"
    help
fi

if [[ "$DATABASE_SERVER" == "" ]]; then
    echo "No DATABASE_SERVER specified"
    help
fi

if [[ "$DATABASE_USER" == "" ]]; then
    echo "No DATABASE_USER specified"
    help
fi

if [[ "$DATABASE_PASSWORD" == "" ]]; then
    echo "No DATABASE_PASSWORD specified"
    help
fi

if [[ "$BACKUP_BASE" == "" ]]; then
    echo "No BACKUP_BASE specified"
    help
fi

BACKUP_NAME="$BACKUP_BASE-$(date -Iseconds).sql"

PGHOST="$DATABASE_SERVER" PGUSER="$DATABASE_USER" PGPASSWORD="$DATABASE_PASSWORD" pg_dumpall -c > "$BACKUP_NAME"

echo "Backup file created"

AWS_DEFAULT_REGION="$AWS_S3_REGION_NAME" aws s3 cp "$BACKUP_NAME" $AWS_STORAGE_BUCKET_NAME

echo "Backup uploaded to S3"
