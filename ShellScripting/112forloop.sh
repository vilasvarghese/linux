#!/bin/bash
#Purpose: For loop example
# START #
for server in `cat /scripts/servers`
do
ping -c 1 $server > /tmp/ping
valid=`echo $?`
if [ $valid -eq 0 ]; then
echo "$server is up"
else
echo "$server is Down"
fi
done
# END #