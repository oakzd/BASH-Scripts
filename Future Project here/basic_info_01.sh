#!/bin/bash

# Script breakdown : This script displays various information to the screen

# Display the text 'Hello"
echo "Hello World"

# Assign a value to a variable, should be ALL CAPS but not required just best practice
FIRST_VARIABLE='script'

# Displays the value of the variable, double quotes must be used
echo "$FIRST_VARIABLE"

# This demonstrates that single qoutes will not cause variable to get expanded
echo '$FIRST_VARIABLE'

# How to print variables with text
echo "This is a shell $FIRST_VARIABLE to help beginners"

# Print a variable using slighty differnt syntax!
echo "This is a shell ${FIRST_VARIABLE} to show beginners basics"

# How to append text to a variable properly
echo "We all know ${FIRST_VARIABLE}ing is a awesome skill to have!"

# How NOT to append text to a variable
echo "We all know $FIRST_VARIABLE is a awesome skill to have!"

# How to combine two variables
SECOND_VARIABLE='ed'
echo "We combined two variables here --> ${FIRST_VARIABLE}${SECOND_VARIABLE}!"

# How to easily reassign a variable
SECOND_VARIABLE='ing'
echo "We combined two variables here --> ${FIRST_VARIABLE}${SECOND_VARIABLE} :)"