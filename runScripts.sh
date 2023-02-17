#!/bin/sh

#set -x

#log files
files=(fileSystem.txt.gz hardwareInfo.txt.gz networkInfo.txt.gz userinfo.txt.gz)
# Define the process name
process_names=(fileSystemScript.sh userInfoScript.sh hardwareInfoScript.sh networkInfoScript.sh)
#Ture = 0 and False = 1
bool_array=(0 0 0 0)
count=0
sum=0
#if log exits, remove it
for file in "${filess[@]}"; do
    if [ -e "$file" ]; then
      rm -f "$file"
    fi
done

#Run scripts in the background
nohup ./fileSystemScript.sh &
nohup ./userInfoScript.sh &
nohup ./hardwareInfoScript.sh &
nohup ./networkInfoScript.sh &

while true; do
    # Search for the process
    for process in "${process_names[@]}"; do
        # Search for the process
        pid=$(pgrep -f $process)
        # Check if the process is running
        if [ -z "$pid" ]; then
          echo "$process is not running."
          bool_array[count]=0
        else
          echo "$process is running with PID $pid."
          bool_array[count]=1
        fi
    done

    for value in "${bool_array[@]}"; do
      sum=$((sum + value))
    done

    if [ $sum -eq 0 ]; then
        gzip -f -k fileSystem.txt hardwareInfo.txt userinfo.txt networkInfo.txt
        exit 0
    fi
    clear
    sleep .4
done
