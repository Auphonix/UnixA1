#!/bin/bash

# This is the script to read username:password_hash formats from a file. Once these are
# loaded, the script attempts to brute force the SHA-256 password_hash to retrieve
# a cleartext password.


# This function is used to double check that all files required are present,
# if this is not true, stop the program
checkFiles()
{
    echo 'Program checking files exist...'
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
    printf "\nLoading from the database\n"

    count=0 # counts the number of entries in file

    while IFS= read line
    do
        IFS=":" tokens=($line) # seperate input line by colon
        is_uname=1 # if token is username

        # The bulk of the loop that seperates username and password from file
        for token in "${tokens[@]}" # cycle all tokens for line
        do
            if [ $is_uname -eq 1 ]; then # if token is username
                is_uname=0
                users[$count]=$token
            else
                is_uname=1
                hashes[$count]=$token
            fi
        done
        echo "user: ${users[count]}         hash: ${hashes[count]}"
        ((count++))
    done < "$r_path$db_data"
}



# Files
r_path="resources/" # Resource path
db_data="db_data.txt"
common_pass="common_pass.txt"
declare -a files=($db_data $common_pass);

# Usernames and passwords
declare -a users
declare -a hashes



#------MAIN------#

# Check files
checkFiles

# Load files
loadDB
