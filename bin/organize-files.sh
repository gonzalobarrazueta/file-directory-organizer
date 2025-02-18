#!/bin/bash

# -z: checks if a string is empty. Returns true if it is. In this case, it's checking if a directory path was provided as an argument
# if the directory string is empty, it means that we will work in the pwd (the default directory), else we will work in the specified directory

if [ -z $1 ]; then
    # We store the path of the current directory
    target_directory=$(pwd)
else
    # We store the directory path provided as an argument
    target_directory=$1
fi

# Create file folders in the target directory
cd "${target_directory}"

# the -p flag tells the mkdir command to ignore errors if the directory already exists. Meaning that it won't overwrite the directory nor stop the program due to the 'File exists' error. If the directory doesn't exist, then it will create it as usual.
mkdir -p Documents
mkdir -p Images
mkdir -p Videos
mkdir -p Music
mkdir -p Archives
