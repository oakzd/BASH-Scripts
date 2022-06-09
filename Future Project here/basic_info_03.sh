#!/bin/bash

#Script breakdown: Diplay UID & Username of user executing script and Display if user is Vagrant.

#Display UID
echo "Hi there your UID = ${UID}"

#Display if UID is not 1000
TEST_THIS_UID='1000'
echo 'Lets check your UID buddy..'
if [[ "${UID}" -ne "${TEST_THIS_UID}" ]]
then
	echo "mmm you must be root cause you UID is not 1000"
	exit 1
fi

#Display Username
 MY_USERNAME=$(id -un)

#Test to see if last executed command exited properly
if [[ "${?}" -ne 0 ]]
then
	echo 'The id command did not exeute properly'
	exit 1
else
	echo "Your username is ${MY_USERNAME}"
fi

#Using a string test condintional.
TEST_THIS_USERNAME='vagrant'
if [[ "${MY_USERNAME}" == ${TEST_THIS_USERNAME} ]]
then
	echo "Your username matches ${TEST_THIS_USERNAME}"
fi

#Test for != for the string
if [[ "${MY_USERNAME}" != "${TEST_THIS_USERNAME}" ]]
then
	echo "Yea buddy you must be root or another user but definalty not ${TEST_THIS_USERNAME}"
	exit 1
fi

exit 0