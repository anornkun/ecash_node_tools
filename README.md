## eCash Node Tools 



### upgrade node version (linux)



    upgrade_ecash_node.sh

Options:

    -i / --interactive : run script in interactive mode


Copy this script to the directory in which your bitcoinabc-x.xx.x directory is located:

    user@hostame:~$ ll
    total 16
    drwxr-xr-x 5 user user 4096 Jan 11 12:33 bitcoin-abc-0.28.5
    -rwxr-xr-x 1 user user 7283 Jan 11 12:33 upgrade_ecash_node.sh



The script checks [Bitcoin ABC's site](https://download.bitcoinabc.org/latest/linux/) for the latest linux node version, and if it is not already running, downloads and runs it, and removes the old version.


---
Author: Anorn 
Date: Dec 2023
License: MIT License
