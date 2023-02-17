#!/bin/sh

#set -x

du -ah > fileSystem.txt

du -hs >> fileSystem.txt

du -hs /home >> fileSystem.txt

du -ch /usr/src/sys/kern/*.c >> fileSystem.txt
