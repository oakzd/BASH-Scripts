#!/bin/bash


# Script Overview : Records number of failed login attempts along ,IP address, and Geo location.
# It will also store all this information into a csv file for easy viewing

# This function is used to print the usage statement.
script_usage_message(){
	echo "Usage: ${0} filename"
	exit 1
}

# Verify that script is run as root 
if [[ "${UID}" -ne 0 ]]
then
	echo 'Sorry you are not root exiting...' >&2
	exit 1
fi

# This function is used to print the usage statement if user does not enter proper filename.
LOG_FILE="${1}"
if [[ ! -e  "${LOG_FILE}" ]]
then
	script_usage_message
	exit 1
fi

#Create a csv header
echo 'Count,IP,Location' >> attempts_logger.csv

#Create variable to compare login attempts to.
LOGIN_LIMIT='10'

#Loop through all the login attempts.
cut -d ':' -f 4 syslog-sample | grep "Failed" | awk '{print $(NF - 3 )}' | sort | uniq -c | sort -rn | while read LoginAttempts IP
do
	if [[ "${LoginAttempts}" -ge "${LOGIN_LIMIT}" ]]
	then
		GEO_LOCATION=$(geoiplookup ${IP} | awk -F ', ' '{print $2}')
		echo " ${LoginAttempts} ,${IP}, ${GEO_LOCATION}"
		echo "${LoginAttempts} ,${IP}, ${GEO_LOCATION}" >> attempts_logger.csv
	fi
done
exit 0