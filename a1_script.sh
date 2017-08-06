#!/bin/bash

# See if the specified files existt
db_data="db_data.txt"
common_pass="common_pass.txt"
r_path="resources/" # Resource path
declare -a files=($db_data $common_pass);



echo 'Program checking files exist...'
for file in "${files[@]}" # Loop through all files
do
    if [ -f $r_path$file ]; then # Check if file exists and is valid file
        echo "$file exists"
    else
        echo "$file doesn't exist"
    fi
done
