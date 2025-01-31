#!/bin/bash
#Purpose: Internal Field Seperator

# START #
LINE=`cat /etc/passwd |grep $1`
IFS=:
set $LINE
echo "User Name = $1"
echo "Password = $2"
echo "UID = $3"
echo "GID = $4"
echo "Description = $5"
echo "Home Directory = $6 "
echo " Current Shell = $7"

# END #