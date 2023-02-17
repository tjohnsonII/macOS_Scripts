##!/bin/sh

#set -x

ip=$(ifconfig | grep inet | grep -v inet6)

echo "$ip"
