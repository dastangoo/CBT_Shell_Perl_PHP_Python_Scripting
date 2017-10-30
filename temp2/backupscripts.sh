#!/bin/bash
# Author: 
# Date:
# Purpose: Used to backup files and/or directories locally and store remotely

USER=superuser
BACKUPDIR=../backup
SCRIPTDIR=../temp2
BACKUPFILE=scripts.backup.`date +%F`
BACKUPHOST=192.168.56.101
REMOTEBACKUP=backup
COUNT=`ls $BACKUPDIR/scripts.* | wc -l`
THRESHOLD=7
if [ $COUNT -le $THRESHOLD ]
then
	tar -czvf $BACKUPDIR/$BACKUPFILE $SCRIPTDIR > /dev/null
	if [ $? != 0 ]; then echo Problems Creating Backup File; fi
	scp $BACKUPDIR/$BACKUPFILE $USER@$BACKUPHOST:$REMOTEBACKUP
	if [ $? != 0 ]; then echo Problems Copying Backup File to Backup Host; fi
fi

# END
   
