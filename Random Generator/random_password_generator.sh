#!/bin/bash

#Script Breakdown: This script generates a random password

# Generate a random password using digits
MY_RANDOM_PASSWORD=${RANDOM}
echo "Hi there your random password is: ${MY_RANDOM_PASSWORD=$}"

# Generate a random password using digits three times in a row
THREE_RANDOM_PASSWORD=${RANDOM}${RANDOM}${RANDOM}
echo "Hi there your random password is: ${THREE_RANDOM_PASSWORD=$}"

# Use the current time to generate a password
CURRENT_DATE_PW=$(date +%s)
echo "Hi there your password is now: ${CURRENT_DATE_PW}"

# Use nano seconds to generate a random password
NANO_PW=$(date +%s)$(date +%N)
echo "Now we are using date and combining it Nano seconds: ${NANO_PW}"

# Using sha256sum to generate a random password!
SHA256SUM_PW=$(date +%s%N | sha256sum | head -c14)
echo "We are using sha256sum to generate a password: ${SHA256SUM_PW}"

# Randomizing the date command
SHA256SUM_PW=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c8)
echo "We are using Random command on date command to generate a password: ${SHA256SUM_PW}"

# Append a special character to last generated password
RANDOM_SPECIAL_CHAR='!@#$%^&*()_+={}[]:/<>,.'
NEW_RANDOM_CHAR_PW=$(echo ${RANDOM_SPECIAL_CHAR} | fold -w1 | shuf | head -c1)
echo "Your random special character password is: ${SHA256SUM_PW}${NEW_RANDOM_CHAR_PW}"

