#!/bin/bash
# --------------------------------------------------------------------------------  
# Script Name: schedule.sh
#
# Description: 
# This script writes an entry into crontab to call the upgrade script every hour.
# This will automatically upgrade the node as soon as a new version is available.
# It will also restart the node after reboot (tbc).
#
# List crontab entries:
# crontab -l
# Remove crontab file:
# crontab -r
# Edit crontab file:
# crontab -e
#
# Author: anornkun, 2024
# License: MIT License
# --------------------------------------------------------------------------------  


# Define the script to be scheduled
SCRIPT_PATH="~/ecash_node_tools/upgrade.sh"

# Define the log file path
LOG_FILE="~/ecash_node_tools/log.txt"

# Generate a random number between 0 and 59 for the offset in minutes
RANDOM_MIN=$(shuf -i 0-59 -n 1)


# Check if crontab exists for the current user
crontab -l > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "Crontab file exists."

    # Check if SCRIPT_PATH is already scheduled in crontab
    if crontab -l | grep -q "$SCRIPT_PATH"; then
        echo "The script is already scheduled in crontab. Exiting."
        exit 0
    else
        echo "Adding the script to crontab."
    fi
else
    echo "No crontab file found. Creating a new one."
fi

# Create a temporary file to hold the current crontab content (if any)
crontab -l > mycron.tmp 2>/dev/null

# Add the new job to the temporary file to run the script every minute
#echo "0 * * * * $SCRIPT_PATH >> $LOG_FILE 2>&1" >> mycron.tmp
echo "$RANDOM_MIN * * * * $SCRIPT_PATH >> $LOG_FILE 2>&1" >> mycron.tmp

# Install the new crontab file
crontab mycron.tmp

# Remove the temporary file
rm mycron.tmp

echo "Cron job added to run $SCRIPT_PATH every hour with logging to $LOG_FILE."




