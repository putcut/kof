#!/bin/bash

# requirements
# alp (json format)
# mysql slow log

workdir=/home/isucon/webapp/php
logfile=bench.log

sudo truncate /var/log/nginx/access.log --size 0
sudo truncate /var/log/mysql/mysql-slow.log --size 0

echo "---Bench Log---" | tee $workdir/$logfile

cd /home/isucon/bench
./bench -target-addr 127.0.0.1:443 2>&1 | tee -a $workdir/$logfile

echo -e "\n---Access Log---\n" | tee -a $workdir/$logfile
sudo cat /var/log/nginx/access.log | alp json | tee -a $workdir/$logfile

echo -e "\n---MySQL Slow Log---\n" | tee -a $workdir/$logfile
sudo cat /var/log/mysql/mysql-slow.log | tee -a $workdir/$logfile

exit 0