#!/bin/bash
## To find given number is Even number or Odd Number

read -p "Enter a number: " number

if [ $((number % 2)) -eq 0 ]; then
    echo "$number is an even number."
else
    echo "$number is an odd number."
fi