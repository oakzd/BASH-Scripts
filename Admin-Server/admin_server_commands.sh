#!/bin/bash

# Script Breakdown : This script will ping and report the status of a list of servers

# Prints out usage statement
script_usage()
{
	echo "Usage: ${0} [-nsv] [-f FILE]..." >&2
	echo 'Many options to pick from' >&2
	echo '   -f  FILE Use the default file' >&2
	echo '   -n       Dry Run, View commands to run' >&2
	echo '   -s       Run with sudo priviledges' >&2
	echo '   -v       Turn on verbosity by displaying the server name.' >&2
	exit 1
}
# Prints out usage statement ^

#Variable Creation here 
SERVER_FILE='/vagrant/servers'
SSH_CONNECTTIMEOUT='-o ConnectTimeout=2'
#Variable Creation here ^

# Verify that script is not run as root 
if [[ "${UID}" -eq 0 ]]
then
	echo 'Sorry you are not allowed to be root exiting... ' >&2
  echo 'Please use the -s option instead' >&2
	script_usage
  exit 1
fi
# Verify that script is not run as root ^

# Enable options here
while getopts f:nsv OPTION
do
 case ${OPTION} in
	 f) SERVER_FILE="${OPTARG}" ;;
	 n) DRY_RUN='true' ;;
	 s) SUDO_PRIVLEGES='sudo' ;;
   v) VERBOSE='true' ;;
	 ?) script_usage ;;
 esac
done
# Enable options here ^

# This will ignore the options given and will start with the arguments
shift "$(( OPTIND - 1 ))"
# This will ignore the options given and will start with the arguments ^

# Verify that a argument is sent through 
if [[ "${#}" -lt 1 ]]
then
	script_usage
fi
# Verify that a argument is sent through ^

#Anything after the options will the commands to run
COMMANDS_TO_RUN=${@}
#Anything after the options will the commands to run ^

# Verify that file exists
if [[ ! -e "${SERVER_FILE}" ]]
then
    echo "Cannot open ${SERVER_FILE}." >&2
    exit 1
fi
# Verify that file exists ^

#Check Exit status by setting it here
INITIAL_EXIT_STATUS='0'
#Check Exit status by setting it here ^

#Loop through the servers on this loop
  for SERVER in $(cat ${SERVER_FILE})
    do
      if [[ "${VERBOSE}" = 'true' ]]
	    then
        echo "${SERVER}"        
      fi
      # This is commands we will be running on server
      SSH_COMMAND="ssh ${SSH_CONNECTTIMEOUT} ${SERVER} ${SUDO_PRIVLEGES} ${COMMANDS_TO_RUN}"
      # This is commands we will be running on server ^
      #Dry run procedure here
      if [[ "${DRY_RUN}" = 'true' ]]
	    then
        echo "DRYRUN: ${SSH_COMMAND} "
      else
        ${SSH_COMMAND}
        #echo ""
        INNER_EXIT_STATUS="${?}"
        #Here we will capture nonzero status and report it
        if [[ "${INNER_EXIT_STATUS}" -ne 0 ]]
        then
          INITIAL_EXIT_STATUS=${INNER_EXIT_STATUS}
          echo "Sorry looks like did not execute on ${SERVER}... " >&2
        fi
        #Here we will capture nonzero status and report it^       
      fi 
      #Dry run procedure here ^
    done
exit ${INITIAL_EXIT_STATUS}
# Loop through the servers on the file ^     