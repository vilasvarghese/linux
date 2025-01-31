#!/bin/bash

number=20
if [[ $number -gt 15 ]]; then
    echo "The number is greater than 15."
elif [[ $number -eq 15 ]]; then
    echo "The number is equal to 15."
else
    echo "The number is less than 15."
fi
