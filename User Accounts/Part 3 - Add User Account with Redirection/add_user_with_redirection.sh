#!/bin/bash

#Script Breakdown: This will add a useraccount with generating a random passwd all on command line
#Script Breakdown: Redirects STDOUT and STDERR to remove clutter and to view info more easily

# Has to run with sudo privileges and exit with 1 if it doesnt
if [[ "${UID}" != 0 ]]
then
	echo 'Sorry you are not root exiting...' >&2
	exit 1
else
	: # this mean do "nothing" and keep going
fi

#Verify that a argument is sent through, then provide a 'man page' usage statement 
if [[ "${#}" -lt 1 ]]
then
	echo "Usage: ${0} USERNAME [COMMENT]... " >&2
	echo 'Create an account on the local system with username and comment field' >&2
	echo "ERROR: Please supply information" >&2
	exit 1
else
	:
fi

# Make UserName the first argument
USER_NAME="${1}"

# Shift over 1 to make rest of the arguments the comment field 
shift 1
FULL_NAME+="${@}"

# create and add the new user with the supplied info
useradd -c "${FULL_NAME}" ${USER_NAME} &> /dev/null

# Checking exit status of previous executed command to verify and then creates account password automatically
if [[ "${?}" != 0 ]]
then
	echo "Sorry looks like account was not created" >&2
	exit 1
else
	echo "Account created successfully Dislayed below" 
	ACCOUNT_PASSWORD=$(date +%s%N${RANDOM} | sha256sum | head -c13) &> /dev/null
	echo "${USER_NAME}:${ACCOUNT_PASSWORD}" | chpasswd --md5 &> /dev/null
	passwd -e ${USER_NAME} &> /dev/null
fi

# Display username,password, and hostname of the account that was created
echo -e "\nFullname: ${FULL_NAME} \nAccount: ${USER_NAME} \nPassword: ${ACCOUNT_PASSWORD}\nHostname: $(hostname) \nAccount creation completed!\n"
echo exit 0