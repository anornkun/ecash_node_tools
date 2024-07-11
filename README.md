## eCash Node Tools 


These tools are designed to make it easy to run an eCash node using [Bitcoin ABC](https://www.bitcoinabc.org/)'s node software.
Your node will automatically update to the latest software version, which is published every two weeks. It's a good idea to keep your node up to date in order to stay in consensus with the network.

In the same directory where your bitcoin-abc-x.xx.x directory is located, run:

    git clone https://github.com/anornkun/ecash_node_tools.git


### Upgrade node version (linux)

The upgrade.sh script checks [Bitcoin ABC's site](https://download.bitcoinabc.org/latest/linux/) for the latest linux node version, and if it is not already running, downloads and runs it, and removes the old version.

Run the script:

    ./ecash_node_tools/upgrade.sh


Options:

    -i  : run script in interactive mode


###  Automatically check node every hour, upgrade if new version is available 

The schedule.sh script adds an entry to the crontab scheduler to call the upgrade.sh script every hour. The node will be automatically upgraded if a new version is found on the Bitcoin ABC site. Also, in the case of a server reboot, the node will be restarted at the next scheduled time. The output of all upgrade.sh calls is logged in ecash_node_tools/log.txt.

Run the script:

    ./ecash_node_tools/schedule.sh







## What is eCash?

[eCash](https://e.cash) is digital money for the Internet. Like regular cash, you can use eCash without banks or other middlemen. You can send it directly to other people. It works through a network of computers across the world. If this sounds like Bitcoin, that's because eCash is based on Bitcoin's software and shares many of its benefits. However, eCash is designed for faster transactions, lower fees, and strong security. A special feature coming soon is instant transaction finality, which most blockchains don't have. eCash is real electronic cash for everyone.


### Why run an eCash node?

Running an eCash node helps the network by making transactions more secure. Each node adds backup and boosts security. The eCash network rewards you for running a node with staking rewards. Currently, the reward is 10% of the block reward. To earn this, you need at least 100 million eCash (XEC) at one address (a single unspent transaction output or UTXO) that hasn't moved for two weeks. Visit this [site](https://avalanche.cash/) to see a visualization of the eCash network.


### How to run an eCash node?

There are different ways to run an eCash node:

1. Rent a Virtual Private Server (VPS): This is a simple option since you don't need to worry about hardware issues or unstable network connections. The eCash team provides tutorials to help you get started. If you have basic Linux knowledge, it’s easy. Follow the steps carefully, and you can set it up in less than an hour, plus the initial synchronization time.
Resources: 
[eCash page](https://e.cash/staking),
[Cain's HOWTO guide](https://proofofwriting.com/120/),
[eCash YouTube channel](https://www.youtube.com/@eCashOfficial),
'eCash Node Support' Telegram channel.


2. Run on Your Own Machine: This requires you to maintain the hardware and ensure a reliable internet connection.

For a hassle-free staking option, you can also use a [commercial service](https://ecashstaking.com/) that manages eCash staking for a commission.





---
Author: anornkun, 2023-2024

License: MIT License
