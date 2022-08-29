#!/bin/bash

#Script Breakdown: This script generates a random password for each user

# Display the first argument typed on the cmd line
echo "So looks like you typed: ${0}"

# Display the path and filename of the script.
echo "Your path is: $(dirname ${0}) and file is: $(basename ${0})"

# Print to usr how many arguments they passed.
#(Inside the script they are parameters, outside they are arguments.)
NUMBER_OF_PARAMETERS="{#}"
echo "You supplied ${#} parameters for this script..."

if [[ ${#} == 0 ]]
then
	echo "Usage: ${0} USERNAME [USERNAME]..."
	exit 1
else
	:
fi

#Generate username&password and display for given parameters
for USER_NAME in "${@}"
do	
	PASSWORD=$(date +%s%N${RANDOM} | sha256sum | head -c13)
	echo "USERNAME: ${USER_NAME} , PASSWD: ${PASSWORD}"
done
