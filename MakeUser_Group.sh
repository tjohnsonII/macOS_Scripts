#!/bin/sh
#set -x

# set the input for lazy convenience
#IFS=$' '

sL="/Users/tim2/Documents/CODING_NETWORKING/macOS_Scripts"
USERS=$(dscl . -list /Users)
NEWUSER="Bob3"
RESULT1="User $NEWUSER exist"
RESULT2="User $NEWUSER does not exist"
# 1 = true
USEREXIST=1;

if [[ sL != $(pwd)  ]]; then
    cd $sL
fi

#If user Bob3 does not exist, create him and corresponding group
for i in $USERS
do
    if [[ $i == $NEWUSER ]]; then
        printf "%s\n" "$RESULT1"
        USEREXIST=1
    else
        printf "%s\n" "$RESULT2"
        USEREXIST=0
    fi
done

if [[ $USEREXIST == 0 ]]; then
    #create user
    sudo dscl . -create /Users/$NEWUSER
    # set user shell
    sudo dscl . -create /Users/$NEWUSER UserShell /bin/bash
    # set real name
    sudo dscl . -create /Users/$NEWUSER RealName “Bob Smith III”
    # set unique ID
    sudo dscl . -create /Users/$NEWUSER UniqueID 5999
    #set group ID
    sudo dscl . -create /Users/$NEWUSER PrimaryGroupID 6000
    #set home directory
    sudo dscl . -create /Users/$NEWUSER NFSHomeDirectory /Local/Users/$NEWUSER
    #set password
    sudo dscl . -passwd /Users/$NEWUSER password

else
    #do not create user
    printf "%s\n" "$RESULT1"
fi
