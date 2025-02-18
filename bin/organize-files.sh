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
