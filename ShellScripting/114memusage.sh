#!/bin/bash
## Monitoring Memory usage of the server

HOSTNAME=$(hostname)
DATED=$(date "+%Y-%m-%d %H:%M:%S")
THRESHOLD=80
TOADDRESS=vilas.varghese@gmail.com

MEMUSAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}' |awk -F. '{print $1}')
if [ $MEMUSAGE -ge $THRESHOLD ]; then
echo "$HOSTNAME, $DATED, %MEMUSAGE" >> /var/log/memusage_history
echo "$HOSTNAME, $DATED, %MEMUSAGE" > /tmp/memusage
mail -s "$HOSTNAME $DATED Mem Usage: $MEMUSAGE" $TOADDRESS <<< /tmp/memusage
fi