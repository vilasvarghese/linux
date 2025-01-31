#!/bin/bash
var="global"

function test_var {
    local var="local"
    echo $var  # Prints: local
}

test_var
echo $var  # Prints: global (original value preserved)
