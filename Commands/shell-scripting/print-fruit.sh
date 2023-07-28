#!/bin/bash
echo "Enter a fruit name:"
read fruit

case $fruit in
    apple)
        echo "It's an apple.";;
    banana)
        echo "It's a banana.";;
    orange)
        echo "It's an orange.";;
    *)
        echo "Unknown fruit.";;
esac
