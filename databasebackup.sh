#!/bin/bash

#Database Backup Script
BACKUP_FILE=/backup/mydatabase_$(date +%Y%m%d).sql
mysqldump -u root -p $DATABASE > $BACKUP_FILE

if [ $(ls -l --b=M $BACKUP_FILE | cut -d " " -f5) -eq $(ls -l --b=M $DATABASE | cut -d" "-f5) ];do
        echo -e "Backup Sucess"
else
        echo "Backup Incomplete"
done