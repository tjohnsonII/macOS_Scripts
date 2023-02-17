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

GROUPS=$(dscl . -list /Groups)
NEWGROUP="TheBob3Group"
RESULT3="Group $NEWGROUP exist"
RESULT4="Group $NEWGROUP does not exist"
GROUPEXIST=1

function rightLocation () {
    printf "%s\n" "Starting Right Location Function"
    if [[ sL != $(pwd)  ]]; then
        cd $sL
    fi
}

function createUser(){
    #If user Bob3 does not exist, create him and corresponding group
    printf "%s\n" "Starting Create User Function"
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
        sudo dscl . -create /Users/$NEWUSER UserShell /bin/sh
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
}

function createGroup(){
    #If Group TheBob3Group does not exist, create him and corresponding group
    printf "%s\n" "Starting Create Group Function"
    for i in $GROUPS
    do
        if [[ $i == $NEWGROUP ]]; then
            printf "%s\n" "$RESULT3"
            USEREXIST=1
        else
            printf "%s\n" "$RESULT4"
            USEREXIST=0
        fi
    done

    if [[ $GROUPEXIST == 0 ]]; then
        printf "%s\n" "$RESULT4"
        #create user
        sudo dscl . -create /Groups/$NEWGROUP
        # set user shell
        sudo dscl . -create /Groups/$NEWGROUP UserShell /bin/sh
        # set real name
        sudo dscl . -create /Groups/$NEWGROUP RealName “The Bob Smith III Group”
        #set password of group
        sudo dscl . create /Groups/$NEWGROUP passwd "*"
        # set unique ID
        sudo dscl . -create /Groups/$NEWGROUP UniqueID 7999
        #set group ID
        sudo dscl . -create /Groups/$NEWGROUP PrimaryGroupID 7000
        #add an admin
        sudo dscl . create /Groups/servsupport GroupMembership $NEWUSER
        #add another user
        #sudo dscl . append /Groups/servsupport GroupMembership

    else
        #do not create group
        printf "%s\n" "$RESULT3"
    fi
}
