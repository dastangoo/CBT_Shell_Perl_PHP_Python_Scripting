#!/bin/bash
# Author: 
# Date:
# Purpose: Used to backup files and/or directories locally and store remotely

USER=superuser
BACKUPDIR=../backup 
SCRIPTDIR="../temp2 /etc"
BACKUPFILE=scripts.backup.`date +%F`.xz
BACKUPHOST=192.168.56.101
REMOTEBACKUP=backup
THRESHOLD=7

function checkbackupdir() {

	if [ ! -e $BACKUPDIR ]
	then
		echo Creating Backup Directory because it doesn\'t exist
		mkdir ../backup
		COUNT=0
#		exit 0
	else
		COUNT=`ls $BACKUPDIR/scripts.* | wc -l`
	fi
}
function backup() {
	if [ $COUNT -le $THRESHOLD ]
	then
		tar -cJvf $BACKUPDIR/$BACKUPFILE $SCRIPTDIR > /dev/null
		if [ $? != 0 ]; then echo Problems Creating Backup File; fi
		scp $BACKUPDIR/$BACKUPFILE $USER@$BACKUPHOST:$REMOTEBACKUP
		if [ $? != 0 ]; then echo Problems Copying Backup File to Backup Host; fi
	fi
}
checkbackupdir
backup
# END
   
