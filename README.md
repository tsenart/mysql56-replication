# MySQL 5.6 Replication Playground

This repository provides a multi-VM Vagrant environment for easy setup
of MySQL 5.6 replication topologies that can be played with.

## Dependencies
* Virtualbox
* Vagrant 1.5.1
* Git

## Running
```sh
$ git clone git@github.com:tsenart/mysql56-replication.git
$ cd mysql56-replication
$ vagrant up # takes a while.... go get a coffee
$ ./install_mysql_utilities.sh
```

The previous commands will start 5 VMs, one master with IP `10.0.0.100`
and 4 slaves with IPs `10.0.0.0.101..104`.
It will also install some MySQL utilities on your local machine.

Follow up on this blog post to learn more about specific MySQL 5.6
replication features and utilities.
http://www.clusterdb.com/mysql/replication-and-auto-failover-made-easy-with-mysql-utilities.
