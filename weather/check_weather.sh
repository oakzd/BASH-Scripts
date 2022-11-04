#!/bin/bash

#Script Breakdown: Checks the weather for any city!

#This takes in user input
read -p "Hello there please enter cities to get currnet weather: enter 'exit' to quit. `echo $'\n> '`" CITY_TEMPS
#This takes in user input ^

# This recreates file everytime to only show last entered cities
> temperatures.txt
# This recreates file everytime to only show last entered cities ^

# Loop through all the cities provided from user
for city in ${CITY_TEMPS[@]}
do   
   sleep 1
   #This further breaks the weather down and leaves us just with City and degrees
   echo $(./weather.sh -s $city) | sed -e 's/+//' -e 's/°F//' >> temperatures.txt
done
# Loop through all the cities provided from user ^

#Sorts it by the degrees and returns results into this file
sort -k2 -rn temperatures.txt > sorted_weather.txt
#Sorts it by the degrees and returns results into this file
exit 0