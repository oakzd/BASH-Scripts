#!/bin/bash

#Script Breakdown: This will add a useraccount to the system

# Has to run with sudo privileges and exit with 1 if it doesnt
if [[ "${UID}" != 0 ]]
then
	echo 'Sorry you are not root exiting...'
	exit 1
else
	: # this mean do "nothing" and keep going
fi

# Prompt user for name, username, and password (clear text) 
read -p 'Please enter your full name: ' FULL_NAME ; read -p 'Please enter your username: ' USER_NAME
read -n 10 -rp $"Please enter your password(10 character limit): " -s ACCOUNT_PASSWORD
 
# create and add the new user with the supplied info
useradd -c "${FULL_NAME}" -m ${USER_NAME}

# Verifies and then creates account password by checking exit status
if [[ "${?}" != 0 ]]
then
	echo "Sorry looks like account was not created"
	exit 1
else
	echo "Account created successfully Dislayed below"
	echo "${USER_NAME}:${ACCOUNT_PASSWORD}" | chpasswd --md5
	passwd -e ${USER_NAME}
fi

# Display username,password, and hostname of the account that was created
MY_HOSTNAME=$(hostname)
echo -e "Fullname: ${FULL_NAME} \nAccount: ${USER_NAME} \nPassword: ${ACCOUNT_PASSWORD}\nHostname: ${MY_HOSTNAME} \nAccount creation completed!"
echo exit 0
