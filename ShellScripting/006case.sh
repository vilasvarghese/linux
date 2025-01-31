#!/bin/bash

dayOfWeek=$(date +%u)  # Get day of week (1-7)
echo $dayOfWeek

case $dayOfWeek in
  1 )
    echo "Today is Monday."
    ;;
  2 )
    echo "Today is Tuesday."
    ;;
  * )  # Default case (any other day)
    echo "It's a weekday."
    ;;
esac
