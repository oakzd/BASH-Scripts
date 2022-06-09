#!/bin/bash

#Script breakdown : Display UID and username for using executing script
#Display if user is root or not

#Display UID
echo "Hey there your UID# is ${UID}"

#Display Username
CURRENT_USER=$(id -un)
echo "Hey there ${CURRENT_USER}, how are you?"

#Display if root or not
echo 'We did a backround check and saw that...'
if [[ "${UID}" -eq 0 ]]
then
	echo 'you are root!'
else
	echo 'you are not root buddy...'
fi