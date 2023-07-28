#!/bin/bash
echo "Enter a number:"
read num
if ((num > 10)); then
    echo "Greater than 10"
else
    echo "Less than or equal to 10"
fi
