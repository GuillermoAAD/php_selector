#!/bin/bash

# Paint the text yellow
function logWarn() {
	START='\033[01;33m'
	END='\033[00;00m'
	MESSAGE=${@:-""}
    echo -e
	echo -e "${START}${MESSAGE}${END}"
}

# Paint the text green
function logInfo() {
	START='\033[01;32m'
	END='\033[00;00m'
	MESSAGE=${@:-""}
    echo -e
	echo -e "${START}${MESSAGE}${END}"
}

# Paint the text red
function logError() {
	START='\033[01;31m'
	END='\033[00;00m'
	MESSAGE=${@:-""}
    echo -e
	echo -e "${START}${MESSAGE}${END}"
}

# Get the current version of php
var=$(php -v)
phpv="${var:4:3}"
echo -e "Current php version: $phpv "
echo -e

# Search for the php versions that are in the system
phpVersionsLS=$(brew list | grep php)

# Empty array that will contain the obtained versions
declare -a phpVersions=()

# Versions are added to the array
for phpV in ${phpVersionsLS[*]}
do
    # the php@ part is removed to leave only the version
    phpV="${phpV:4:3}" 
    # Check if the variable is an empty string then it is the most current version (8.2)
    if [ -z "$phpV" ]; then
        phpV=8.2
    fi
    phpVersions+=("${phpV}")
done

# Sort the array with versions
phpVersions=($(for element in "${phpVersions[@]}"; do echo "$element"; done | sort))

# Available PHP versions are shown
echo "Available php versions:"
# Iteration counter
c=1
# Iterates over the versions of the array
for i in "${phpVersions[@]}"
do
    echo "$c) $i"
    ((c++))
done

echo -e

# # The PHP version to be changed is requested
echo "Enter the version of PHP you want to use (option number):"
read selected_php

# Check if the version you want to change is the same as the one already active
if [[ ${phpVersions[selected_php - 1]} = $phpv ]]
then
    echo "Version ${phpVersions[selected_php - 1]} already active."
    logWarn "Version ${phpVersions[selected_php - 1]} already active."
    sleep 1
    exit 0
fi

# Check the selected version to change
if ((selected_php - 1 >= 0)) && ((selected_php - 1 < ${#phpVersions[@]})); then
        echo -e
        echo -e "Changing php to version ${phpVersions[selected_php - 1]}"

        unlink=$(brew unlink php@${phpv})
        link=$(brew link php@${phpVersions[selected_php - 1]})

        logInfo "PHP changed to version ${phpVersions[selected_php - 1]}"
    else
        logError "PHP version not found."
fi

sleep 1