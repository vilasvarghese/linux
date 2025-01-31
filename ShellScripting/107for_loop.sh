#!/bin/bash


fruits=( "Apple" "Orange" "Banana" "Sapota" )
fruits[3]='Green Apple'
for fruit in ${fruits[@]}
do
        echo "Fruit Name is $fruit"
done

echo "Number of Fruits in Bucket is" ${#fruits[@]}
echo "All Fruits ${fruits[@]}"

# END #