#!/bin/bash

# Script Breakdown : disable, delete, and archive account

 ARCHIVE_DIR='/archive'

script_usage(){
	echo "Usage: ${0} [-vrda] USER [ACCOUNT_NAME]..." >&2
	echo 'Many options to pick from' >&2
	echo '   -v  Increase verbosity.' >&2
	echo '   -r	 removes the home directory' >&2
	echo '   -d  deletes the account' >&2
	echo '   -a  archives the home directory' >&2
	exit 1
}

# Create a function that displays
log(){
	local MESSAGE="${@}"
	if [[ "$VERBOSE" = 'true' ]]
	then
	  echo "${MESSAGE}"
	fi
}

# Run as root 
if [[ "${UID}" -ne 0 ]]
then
	echo 'Sorry you are not root exiting...' >&2
	exit 1
fi

while getopts vdra OPTION
do
 case ${OPTION} in
	 v) VERBOSE='true' log 'Verbose mode enabled.' ;;
	 d) DELETE_ACCOUNT='true' ;;
	 r) REMOVE_HOME_DIR='-r' ;;
	 a) ARCHIVE='true' ;;
	 ?) script_usage ;;
 esac
done

# This will ignore the options given and will start with the arguments so we can shift through them
shift "$(( OPTIND - 1 ))"


# Verify that a argument is sent through so script can function
if [[ "${#}" -lt 1 ]]
then
	script_usage
fi

# This for loop will function as the main code
# Check for UID, archive , delete, and disabling account
for ACCOUNT_NAME in "${@}"
do
	echo "Processing user: ${ACCOUNT_NAME}"
	
	# We want to make sure that only new accounts are being maniuplated not system accounts
	USERID=$(id -u ${ACCOUNT_NAME})
	if [[ "${USERID}" -lt 1000 ]]
	then
		echo "Failed to remove account ${ACCOUNT_NAME} since UID is ${USERID}"
		exit 1
	fi

	# This will create an archive of the users home directory and store it were needed.
	if [[ "${ARCHIVE}" == 'true' ]]
	then
		# Make sure the ARCHIVE_DIR exists
		if [[ ! -d "${ARCHIVE_DIR}" ]]
		then
			echo "Creating the directory : ${ARCHIVE_DIR}"
			mkdir -p ${ARCHIVE_DIR}
			if [[ "${?}" -ne 0 ]]
			then
				echo "Sorry looks like directory: ${ARCHIVE_DIR} could not be created >&2"
				exit 1
			fi
		fi
	# Archive the users home directory and move it into the archive folder
	HOME_DIR="/home/${ACCOUNT_NAME}"
	ARCHIVE_FILE="${ARCHIVE_DIR}/${ACCOUNT_NAME}.tar.gz"
		if [[ -d "${HOME_DIR}" ]]
		then
			echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
			tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
			if [[ "${?}" -ne 0 ]]
			then
				echo "Could not create ${ARCHIVE_FILE}"
				exit 1
			fi
	else
		echo "${HOME_DIR} does not exist or is not a directory"
		exit 1
		fi
	fi

	if [[ "${DELETE_ACCOUNT}" = 'true' ]]
	then
		userdel ${REMOVE_HOME_DIR} ${ACCOUNT_NAME}
		# Verify that account was deleted
		if [[ "${?}" -ne 0 ]]
		then
			echo "The account: ${ACCOUNT_NAME} was not deleted" >&2
			exit 1
		fi
		echo "The account ${ACCOUNT_NAME} was deleted"
	else
		chage -E 0 ${ACCOUNT_NAME}
		if [[ "${?}" -ne 0 ]]
		then
		 echo "The account: ${ACCOUNT_NAME} was not disabled" >&2
		 exit 1
		fi
		echo "The account ${ACCOUNT_NAME} was disabled"
	fi
done

log "All done good job!"
exit 0