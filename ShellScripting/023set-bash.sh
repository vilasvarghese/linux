#!/bin/bash
#Purpose: Set assigns its arguments to the positional parameters
# START #
set `date`
echo "--------------In windows--------------"
echo "Today is $1"
echo "Month is $2"
echo "Date is $3"
echo "Year H:M:S $4"
echo "Time is $5"
echo "AM/PM is $6"
set -x
# END #