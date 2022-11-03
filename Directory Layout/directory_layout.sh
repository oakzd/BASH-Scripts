#!/bin/bash

#Script Breakdown : Prints all sub-directories of current/provided path.

# Checks if an argument was supplied
if [ "$1" != "" ]
   then 
   cd "$1" ; pwd
fi
# Checks if an argument was supplied ^

# Here we check for a empty directory
EMPTY_DIRECTORY=$(ls -F -1 | grep "/" | wc -l)
if [ "${EMPTY_DIRECTORY}" = 0 ]   # Check if no folders
    then echo "   -> no sub-directories for path selected..."
fi
# Here we check for a empty directory ^

#Here is where we change the format for the layout
ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
echo
#Here is where we change the format for the layout ^