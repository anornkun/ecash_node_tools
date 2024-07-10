## eCash Node Tools 


These tools are designed to make it easy to run an eCash node using [Bitcoin ABC](https://www.bitcoinabc.org/)'s node software.
Your node will automatically update to the latest software version, which is published every two weeks. It's a good idea to keep your node up to date in order to stay in consensus with the network.

### What is eCash?

[ECash](https://e.cash) is electronic cash for the Internet. Similar to physical cash, it can be used without any middle man, and can be sent directly from peer to peer. It works using a distributed network of computers across the world. If this sounds similar to Bitcoin, that's because eCash is a software fork of Bitcoin and has many of the great features of Bitcoin. However, it is built for higher throughput, lower transaction fees, and bulletproof security. A key feature yet to be unlocked is near-instant transaction finality, something that most blockchains lack. ECash is true electronic cash for everyone.


### Why run an eCash node?

The eCash network benefits from distribution of nodes across the globe to ensure fast and secure transactions. Each node adds redundancy and increases the security of the network. The eCash network incentivizes running a node by paying staking rewards. At the moment this reward is set to 10% of the block reward. Note that for this you will need a minimum of 100 million eCash (ticker: XEC) at a single address (specifically, a single utxo) that has not moved for two weeks.

### How to run an eCash node?

There are a number of ways to run an eCash node: You can rent a virtual private server (VPS) and install and run the node software. This is a great way to run a node without having to worry about hardware failure or flaky home broadband.
The eCash team has released a series of simple tutorials to get you set up. It's easy if you have some basic linux knowledge, but if you follow the steps carefully, it will require only an hour or two to get started, plus the time it takes to synchronize the node once at the beginning.

Resources: 
[Cain's HOWTO guide](https://proofofwriting.com/120/)
[eCash YouTube channel](https://www.youtube.com/@eCashOfficial)

It is also possible to run an eCash node on your own machine, but this means that you need to maintain the machine and ensure a consistent internet connection to keep your node connected.

If you want a simple way to earn staking rewards, there is also a [commercial service](https://ecashstaking.com/) that provides eCash in a simple way for a commission. In this case, you don't need any of this code, just stake and earn (but less).




###  Automatically check node every hour, upgrade if new version is available 

The schedule.sh script adds an entry to the crontab scheduler to call the upgrade.sh script every hour. The node will be automatically upgraded if a new version is found on the Bitcoin ABC site. Also, in the case of a server reboot, the node will be restarted at the next scheduled time. The output of all upgrade.sh calls is logged in ecash_node_tools/log.txt.

Run the script:

    ./ecash_node_tools/schedule.sh



### Upgrade node version (linux)

The upgrade.sh script checks [Bitcoin ABC's site](https://download.bitcoinabc.org/latest/linux/) for the latest linux node version, and if it is not already running, downloads and runs it, and removes the old version.

In the same directory where your bitcoin-abc-x.xx.x directory is located, run:

    git clone https://github.com/anornkun/ecash_node_tools.git

Then run the script:

    ./ecash_node_tools/upgrade.sh


Options:

    -i  : run script in interactive mode





---
Author: anornkun, 2023-2024

License: MIT License
