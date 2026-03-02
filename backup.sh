#!/bin/bash

# 1. Define variables
TIMESTAMP=$(date +"%Y-%m-%d")
BACKUP_NAME="mall_backup_${TIMESTAMP}.tar.gz"
SOURCE_DIR="/home/timmylionel/minecraft-docker/data"
BUCKET="gs://mc-v2-backups"

# 2. Run the backup
echo "Starting backup of $SOURCE_DIR to $BUCKET/$BACKUP_NAME"
tar -czvf - "$SOURCE_DIR" | /usr/bin/gcloud storage cp - "$BUCKET/$BACKUP_NAME"

# 3. Log the result
if [ $? -eq 0 ]; then
    echo "✅ Backup Successful: $TIMESTAMP" >> /home/timmylionel/minecraft-docker/backup.log
else
    echo "❌ Backup FAILED: $TIMESTAMP" >> /home/timmylionel/minecraft-docker/backup.log
fi
