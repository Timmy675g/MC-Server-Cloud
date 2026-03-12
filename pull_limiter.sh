#!/bin/bash

# Config File
LIMIT=3
STATE_FILE=".pull_count"
DATE_TODAY=$(date +%Y-%m-%d)

# Initialize state file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "$DATE_TODAY 0" > "$STATE_FILE"
fi

# Read the last date and count
READ_DATA=$(cat "$STATE_FILE")
LAST_DATE=$(echo $READ_DATA | cut -d' ' -f1)
COUNT=$(echo $READ_DATA | cut -d' ' -f2)

# Reset count if it's a new day
if [ "$DATE_TODAY" != "$LAST_DATE" ]; then
    COUNT=0
fi

# Check if we are over the limit
if [ "$COUNT" -ge "$LIMIT" ]; then
    echo "⚠️ [$(date)] Pull limit ($LIMIT) reached for today. Skipping to prevent huge network bills..."
    exit 0
fi

# --- EXECUTE THE TASK ---
echo "🚀 Running git pul, please wait!... (Attempt $((COUNT + 1))/$LIMIT)..."
git pull

# Update the count and save to the state file
NEW_COUNT=$((COUNT + 1))
echo "$DATE_TODAY $NEW_COUNT" > "$STATE_FILE"
