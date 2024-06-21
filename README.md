## eCash Node Tools 



### upgrade node version (linux)

The upgrade.sh script checks [Bitcoin ABC's site](https://download.bitcoinabc.org/latest/linux/) for the latest linux node version, and if it is not already running, downloads and runs it, and removes the old version.

In the same directory where your bitcoin-abc-x.xx.x directory is located, run:

    git clone https://github.com/anornkun/ecash_node_tools.git

Then run the script:

    ./ecash_node_tools/upgrade.sh


Options:

    -i  : run script in interactive mode





###  automatically run script every hour

The schedule.sh script adds an entry to the crontab scheduler to call the upgrade.sh script every hour. The node will be automatically upgraded if a new version is found on the Bitcoin ABC site. Also, in the case of a server reboot, the node will be restarted (to be confirmed). The output of all  upgrade.sh calls is logged in ecash_node_tools/log.txt.

Run the script:

    ./ecash_node_tools/schedule.sh


---
Author: anornkun, 2023-2024
License: MIT License
