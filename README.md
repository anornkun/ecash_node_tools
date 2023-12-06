## eCash Node Tools 



### upgrade node version (linux)

The script checks [Bitcoin ABC's site](https://download.bitcoinabc.org/latest/linux/) for the latest linux node version, and if it is not already running, downloads and runs it, and removes the old version.

In the same directory where your bitcoin-abc-x.xx.x directory is located, run:

    git clone https://github.com/anornkun/ecash_node_tools.git

Then run the script:

    ecash_node_tools/upgrade.sh


Options:

    -i  : run script in interactive mode




---
Author: Anorn 

Date: Dec 2023

License: MIT License
