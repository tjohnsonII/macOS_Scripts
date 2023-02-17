#!/bin/sh

#set -x

whoami > userinfo.txt

who >> userinfo.txt

w >> userinfo.txt

last -10 >> userinfo.txt
