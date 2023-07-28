#!/bin/bash
echo "Enter a filename:"
read filename
if [ -e "$filename" ]; then
    echo "File exists."
else
    echo "File does not exist."
fi
