#!/bin/bash

# See if the specified files existt
db_date = "db_data.txt"
common_pass = "common_pass.txt"
r_path = "resources/" # Resource path



echo 'Program checking files exist...'
if [-f $r_path$db_data]; then
    echo "File <$db_data> exists"
else
    echo "File <$db_data> doesn't exist"
fi
