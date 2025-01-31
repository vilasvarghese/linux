#!/bin/bash

# START #
echo -e "Please Enter the IP Address to Ping: \c"
read -r ip
until ping $ip 
do
        echo "Host $ip is Still Down"
        sleep 1
done

echo "Host $ip is Up Now"

# END #
