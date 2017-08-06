#!/bin/bash

# This is the script to read username:password_hash formats from a file. Once these are
# loaded, the script attempts to brute force the SHA-256 password_hash to retrieve
# a cleartext password.


# This function is used to double check that all files required are present,
# if this is not true, stop the program
checkFiles()
{
    printf '\n-------Checking resources exist-------\n'
    for file in "${files[@]}" # Loop through all files
    do
        if [ -f $r_path$file ]; then # Check if file exists and is valid file
            echo "$file exists"
        else
            echo "$file doesn't exist"
            exit 1
        fi
    done
}


# This function attempts to load the content of the userDB and store the appropriate
# information in it's respective variables
loadDB()
{
    printf "\n----Loading user from the database-----\n"

    while IFS= read line
    do
        IFS=":" tokens=($line) # seperate input line by colon
        is_uname=1 # if token is username

        # The bulk of the loop that seperates username and password from file
        for token in "${tokens[@]}" # cycle all tokens for line
        do
            if [ $is_uname -eq 1 ]; then # if token is username
                is_uname=0
                users[$num_entries]=$token
            else
                is_uname=1
                hashes[$num_entries]=$token
            fi
        done
        printf "user: ${users[num_entries]}\t\t\thash: ${hashes[num_entries]}\n"
        ((num_entries++))
    done < "$r_path$db_data"
}

# This function loads a list of common passwords to find a match between user
# password hashes
commonPassSearch()
{
    printf "\n----Common password search-----\n"
    while IFS= read line
    do
        try=$(echo "$guess" | sha256sum | awk '{print $1}')
        if [ "$try" == "$pwhash" ] ; then
            echo "The password is $guess"
        fi
        for i in $(seq 1 $num_entries)
        do
            pass_as_hash=$()
        done
    done < "$r_path$common_pass"
}



# Files
r_path="resources/" # Resource path
db_data="db_data.txt"
common_pass="common_pass.txt"
declare -a files=($db_data $common_pass);

# Usernames and passwords
num_entries=0 # the number of entries in file
pass_found=0 # number of found password
declare -a users
declare -a hashes



#------MAIN------#

# Check files
checkFiles

# Load files
loadDB

# 1st attempt to find passwords using common password list
commonPassSearch
