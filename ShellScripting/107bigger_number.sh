#!/bin/bash


echo -e "enter the a value: \c"
read a
echo -e "enter the b value: \c"
read b
if test "$a" -gt "$b" ; then
        echo "$a is greater than $b"
else
        echo "$b is greater than $a"
fi

# END #