#!/bin/sh

#set -x

system_profiler > hardwareInfo.txt

system_profiler SPHardwareDataType >> hardwareInfo.txt

ioreg >> hardwareInfo.txt

