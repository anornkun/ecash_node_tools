#!/bin/bash
# --------------------------------------------------------------------------------  
# Script Name: upgrade.sh
#
# Description: 
# Run this script from the same directory in which bitcoinabc-x.xx.x directory is located.
# The script checks Bitcoin ABC's site for the latest linux node version, and if not already running,
# downloads and runs it, and removes the old version.
#
# Options:
# -i / --interactive : run script in interactive mode
#
# Author: Anorn 
# Date: Dec 2023
# License: MIT License
# --------------------------------------------------------------------------------  

# Check if required commands are available
command -v curl >/dev/null 2>&1 || { echo >&2 "Error: curl is required but not installed. Aborting."; exit 1; }
command -v wget >/dev/null 2>&1 || { echo >&2 "Error: wget is required but not installed. Aborting."; exit 1; }


echo "--------------------"
echo "Upgrading eCash node"
echo "--------------------"
echo


# --------------------------------------------------------------------------------  
# parse command line parameters
# -i for interactive mode, asking user before stopping node and deleting files
# --------------------------------------------------------------------------------  
interactive_mode=false
while [ "$#" -gt 0 ]; do
    case "$1" in
        -i|--interactive)
            # Flag is set, enable interactive mode
            interactive_mode=true
            ;;
        *)
            echo "Error: Unknown flag '$1'. Use -i or --interactive to enable interactive mode."
            exit 1
            ;;
    esac
    shift
done


# --------------------------------------------------------------------------------  
# check latest node version available on Bitcoin ABC's site
# --------------------------------------------------------------------------------  
echo "Checking latest available node version from Bitcoin ABC's site"
directory_listing=$(curl -s -w "%{http_code}" https://download.bitcoinabc.org/latest/linux/ -o /dev/null)

# Check if the HTTP response code is 200 (success)
if [ "$directory_listing" -eq 200 ]; then
    # Directory is available, proceed to extract the latest Bitcoin ABC version string
    filename_latest=$(curl -s https://download.bitcoinabc.org/latest/linux/ | grep -o 'bitcoin-abc-[0-9.]\+-x86_64-linux-gnu.tar.gz' | sort -V | tail -n1)
else
    # if directory is not available, exit script
    echo "Error: Directory not found (HTTP Status Code: $directory_listing)"
    exit 1
fi


# if file is not available, empty script
if [ -z "$filename_latest" ]; then
    echo "Error: File not found in the directory."
    exit 1
fi

# filename of the tar.gz file
#echo "Latest version file: $filename_latest"

# extract only the version string, e.g. 'bitcoin-abc-0.28.4'
version_latest=$(echo "$filename_latest" | sed 's/-x86\_64-linux-gnu\.tar\.gz//')

echo "Latest version available at bitcoinabc: $version_latest"



# --------------------------------------------------------------------------------  
# check which version the current node is running
# --------------------------------------------------------------------------------  
echo
echo "Checking running version"
# Check if a process containing "bitcoind" is running
if pgrep -f "bitcoind" > /dev/null; then
  # Get the process details
  process_details=$(ps aux | grep "bitcoind" | grep -v "grep")

  # Extract the version using a regular expression
  if [[ $process_details =~ bitcoin-abc-[0-9]+\.([0-9]+\.[0-9]+) ]]; then
    version_old="${BASH_REMATCH[0]}"
    echo "This node is currently running version: $version_old"
  else
    echo "Version not found in process details"
  fi
else
  echo "No 'bitcoind' process is currently running"
  version_old="none"
fi


# --------------------------------------------------------------------------------  
# check if the running (old) version is the latest
# --------------------------------------------------------------------------------  
if [[ $version_latest == *$version_old* ]]; then
    echo
    echo "This node is already running the latest version. You're all good."
    exit 1
else
    echo "Upgrading to version $version_latest"
fi


# --------------------------------------------------------------------------------  
# stop running the old version
# --------------------------------------------------------------------------------  
if [ "$version_old" != "none" ]; then
	# Check if in interactive mode
	if [ "$interactive_mode" = true ]; then
		read -p "Do you want to stop running your node? (y/n): " response

		if [[ "$response" == "Y" || "$response" == "y" ]]; then
		    echo "You chose to proceed."
		    echo "Stopping old version $version_old"
		    cmd="./$version_old/bin/bitcoin-cli stop"
		    eval "$cmd"
		    echo "Stopped $version_old"
		 else
		    echo "You chose not to proceed. Exiting the script."
		    exit 1 
		fi
	else # non-interactive
		echo "Stopping old version $version_old"
		cmd="./$version_old/bin/bitcoin-cli stop"
		eval "$cmd"
		echo "Stopped $version_old"
	fi
fi


# --------------------------------------------------------------------------------  
# download, extract and run new version 
# --------------------------------------------------------------------------------  
echo
echo "Downloading latest version: $version_latest"
url="https://download.bitcoinabc.org/latest/linux/$filename_latest"
wget "$url"

# Check the exit status of wget
if [ $? -eq 0 ]; then
  echo "Download of $filename_latest successful"
else
  echo "Error: Download of $filename_latest failed. Exiting the script."
  exit 1
fi

echo
echo "Extracting $filename_latest"
tar xzf "$filename_latest"
rm -rf "$filename_latest"

echo
echo "Starting the node: $version_latest"
cmd="./$version_latest/bin/bitcoind -daemon"
eval "$cmd"


# --------------------------------------------------------------------------------  
# double check if it's running
# --------------------------------------------------------------------------------  
if pgrep -f "bitcoind" > /dev/null; then
  # Get the process details
  process_details=$(ps aux | grep "bitcoind" | grep -v "grep")

  # Extract the version using a regular expression
  if [[ $process_details =~ bitcoin-abc-[0-9]+\.([0-9]+\.[0-9]+) ]]; then
    version_current="${BASH_REMATCH[0]}"
    echo "Confirming that node is currently running version: $version_current"
    if [[ $version_latest == *$version_current* ]]; then
        echo "$version_current is the latest version. All good."
    else
        echo "$version_current is not the latest version. Check why."
        exit 1
    fi
  else
    echo "Version not found in process details. Check why."
    exit 1
  fi
else
  echo "No 'bitcoind' process is currently running. Check why."
  exit 1
fi


# --------------------------------------------------------------------------------  
# Delete old version
# --------------------------------------------------------------------------------  
if [ "$version_old" != "none" ]; then
	if [ "$interactive_mode" = true ]; then
                echo
		read -p "Do you want to delete the old node version directory? (y/n): " response

		# Check the response using an if statement
		if [[ "$response" == "Y" || "$response" == "y" ]]; then
		    echo "Deleting $version_old"
		    rm -rf "$version_old"
		else
		    echo "OK, keeping $version_old"
		fi
	else
		echo "Deleting $version_old"
		rm -rf "$version_old"
	fi
fi
	

echo
echo "Upgrade successful. Running latest version $version_latest"
