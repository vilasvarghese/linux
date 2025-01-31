#!/bin/bash
## Purpose: To Create a users in Linux

check_command_success() {
	if [ $? -ne 0 ]; then
		echo "Error: $1"
		exit 1
	fi
}

if [ $(id -u) -ne 0 ]; then
	echo "Error: Only root may add a user to the system."
	exit 2
fi

# Prompt for the username and password
read -p "Enter username: " username
read -s -p "Enter password: " password
echo

if id "$username" &>/dev/null; then
	echo "Error: User '$username' already exists!"
	exit 1
fi

encrypted_password=$(perl -e 'print crypt($ARGV[0], "password")' "$password")
check_command_success "Failed to encrypt the password."

useradd -m -p "$encrypted_password" "$username"
check_command_success "Failed to add the user."

passwd -e "$username"
check_command_success "Failed to set password expiry."

echo "Success: User '$username' has been added to the system!"
