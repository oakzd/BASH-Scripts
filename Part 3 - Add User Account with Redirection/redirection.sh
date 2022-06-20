#!/bin/bash

#Script Breakdown: Shows varoius IO redirection.

# Redirect STDOUT to a file
MY_FILE="/tmp/data"
head -n3 /etc/passwd > ${MY_FILE}

# Redirect STDIN to a program
read LINE < ${MY_FILE}
echo "Line contents are: ${LINE}"

# Redirect STDOUT to a file, overwriting the file
head -n5 /etc/passwd > ${MY_FILE}
echo -e "Contents of ${MY_FILE}:"
cat ${MY_FILE}

# Redirect STDOUT to a file, appending to the file
echo "${RANDOM} ${RANDOM}" >> ${MY_FILE}
echo " $(date +%s%N)${RANDOM} ${RANDOM}" >> ${MY_FILE}
echo -e "Contents of ${MY_FILE}:"
cat ${MY_FILE}

# Redirect STDIN explicitly, using FD 0
read LINE 0< ${MY_FILE}
echo -e "LINE contains: ${MY_FILE}"

# Redirect STDOUT explicitly, using FD 1 overwriting the file
head -n3 /etc/passwd 1> ${MY_FILE}
echo -e "Contents of : ${MY_FILE}"
cat ${MY_FILE}

#Redirect STDERR into a file explicitly using FD 2
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakeNEWS 2> ${ERR_FILE}
cat ${ERR_FILE}

# Redirect both STDOUT&STDERR on same line to same file
#  2>&1 or &>
head -n4 /etc/passwd /fakeNEWS &> ${MY_FILE}
echo -e "Contents of : ${MY_FILE}"
cat ${MY_FILE}

# Redirect both STDOUT&STDERR using PIPING on same line to same file
head -n4 /etc/passwd /fakeNEWS |& cat -n
echo -e "Contents of : ${MY_FILE}"
cat ${MY_FILE}

# Send output to STDERR (it becomes STDERR its self!)
echo -e "Oh my gosh ERROR ERROR ERROR" >&2

# Discard STDOUT
head -n3 /etc/passwd 1> /dev/null
echo -e "Discarding STDOUT:"

# Discard STDERR
head -n3 /etc/passwd  /fakeNEWS 2> /dev/null
echo -e "Discarding STDERR:"

# Discard STDERR
head -n3 /etc/passwd  /fakeNEWS &> /dev/null
echo -e "Discarding STDOUT and STDERR:"

# Clean up these files
rm ${MY_FILE} ${ERR_FILE} &> /dev/null