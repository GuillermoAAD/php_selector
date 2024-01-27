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
echo -e "Current version of php: $phpv "
echo -e

# Search for the php versions that are in the system
phpVersionsLS=$(ls /etc/php)

# Empty array that will contain the obtained versions
declare -a phpVersions=()

# Versions are added to the array
for phpV in ${phpVersionsLS[*]}
do
    phpVersions+=("${phpV}")
done

# Available PHP versions are shown
echo "Available versions of php:"
# Iteration counter
c=1
# Iterates over the versions of the array
for i in "${phpVersions[@]}"
do
    echo "$c) $i"
    ((c++))
done

echo -e

# The PHP version to be changed is requested
echo "Enter the version of PHP you want to use (option number):"
read selected_php

# Check if the version you want to change is the same as the one already active
if [[ ${phpVersions[selected_php - 1]} = $phpv ]]
then
    #echo "Version ${phpVersions[selected_php - 1]} already active."
    logWarn "Version ${phpVersions[selected_php - 1]} already active."
    sleep 1
    exit 0
fi

# Check the selected version to change
case ${phpVersions[selected_php - 1]} in
    "5.6"|"7.4"|"8.1")
        echo -e
        echo -e "Changing php to version ${phpVersions[selected_php - 1]}"
        
        # I save it in a variable so that it is not shown in the console
        # Updating where php takes from
        updt_alt=$(sudo update-alternatives --set php /usr/bin/php${phpVersions[selected_php - 1]})
        # Disabling active version of php
        dismod=$(sudo a2dismod php$phpv)
        # Enabling new version of php
        enmod=$(sudo a2enmod php${phpVersions[selected_php - 1]})
        # Restart the apache server
        sudo systemctl restart apache2

        logInfo "PHP changed to version ${phpVersions[selected_php - 1]}"
        ;;
    *)
        logError "PHP version not found."
        ;;
esac

sleep 1