#!/bin/bash
#Usage: ./015getopts.sh -a Hello -b World

# START #

while getopts :a:b: opt; do #getopts command is used to parse command-line options. Both a and b requires parameters. opt is a variable where values will be stored like has OPTARG is a special variable which will be populated as you iterate.
        case $opt in
                a) ap=$OPTARG;; #" just in case the string includes spaces 
                b) bo=$OPTARG;;
                ?) echo "I Dont know What is $OPTARG is"
        esac
done

echo "Option A = $ap and Option B = $bo"

# END #
