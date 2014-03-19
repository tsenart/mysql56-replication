#!/bin/sh

set -x
set -e

wget http://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-1.1.6.zip
unzip mysql-connector-python-1.1.6.zip && cd mysql-connector-python-1.1.6
sudo python setup.py install
cd ../
wget http://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-utilities-1.3.6.zip
unzip mysql-utilities-1.3.6.zip && cd mysql-utilities-1.3.6
sudo python setup.py install
cd ../
sudo rm -rf mysql-*
