#!/bin/bash

# START #

echo "enter the user name "
read NM
echo "`useradd -d /users/$NM $NM`"

# END #
