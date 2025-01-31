#!/bin/bash
#Purpose: If else statement example
#Version:1.0
# START #
echo -e "Enter any value: \c"
read -r a
echo -e "Enter any value: \c"
read -r b

if [ $a -gt $b ]; then
echo "$a is greater than $b"
else
echo "$b is greater than $a"
fi
# END #