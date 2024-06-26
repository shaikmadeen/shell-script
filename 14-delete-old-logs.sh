#!/bin/bash

# APP_LOGS_DIR=/home/centos/app-logs

DATE=$(date +%F)
LOGSDIR=/home/centos/shellscript-logs
SCRIPT_NAME=$0
LOGFILE=$LOGSDIR/$0-$DATE.log

FILES_TO_DELETE=$(find /home/centos/app-logs -name "*.log" -type f -mtime +14)

echo "$FILES_TO_DELETE"

while read line
do
   echo "Deleting $line" $>> $LOGFILE
   rm -rf $line 
done <<< $FILES_TO_DELETE    