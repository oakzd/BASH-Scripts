#!/bin/bash

#Script Breakdown : Creates an account and will prompt for account login info

# Ask user for username
read -p 'Hi there please enter your username: ' USER_NAME

# Ask user for their real name
read -p 'Hi there please enter your real name: ' REAL_NAME

# Ask user for a password
read -n 5 -p "Hi there please enter a password: " -s PASSWORD_ACCOUNT
echo -e
#echo ${PASSWORD_ACCOUNT}

# Create the user account
useradd -c "${REAL_NAME}" -m ${USER_NAME}

# Set the password for the user account
echo "${USER_NAME}:${PASSWORD_ACCOUNT}" | chpasswd --md5

# Force user to change password on their first login
passwd -e ${USER_NAME}

exit 0