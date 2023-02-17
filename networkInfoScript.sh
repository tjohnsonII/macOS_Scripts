#!/bin/sh

#set -x

ifconfig > networkInfo.txt

netstat -a >> networkInfo.txt

netstat -r >> networkInfo.txt

arp -a >> networkInfo.txt

nslookup google.com >> networkInfo.txt

traceroute google.com >> networkInfo.txt

hostname >> networkInfo.txt


