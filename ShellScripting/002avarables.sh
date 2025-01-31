#!/bin/bash

#This code shows the different variables allowed in shell scripting
# START #

A=10
Ba=23
BA=45
HOSTNAME=$(hostname)
DATE=`date`
#Below variables are not allowed
1value=333
False@Var=False

echo "Variable A Value: $A"
echo "Variable Ba Vaule: $Ba"
echo "Variable BA Vaule: $BA"
echo "Variable HOST value: $HOSTNAME"
echo "Variable DATE value: $DATE"
echo "Wrong Variable 1value $1value"
echo 'False @ Variable' $False@Var

# END #
