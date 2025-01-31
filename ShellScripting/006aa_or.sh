#!/bin/bash
#Purpose: OR operator example

# START #

echo -e "Enter First Numeric Value: \c"
read -r t
echo -e "Enter Second Numeric Value: \c"
read -r b

if [ $t -le 20 -o $b -ge 30 ]; then
echo "Statement is True"
else
echo "False Statement, Try Again."
fi

# END #