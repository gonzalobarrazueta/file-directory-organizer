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
mkdir -p Pictures
mkdir -p Videos
mkdir -p Music
mkdir -p Archives

# Here, we're creating a string with the ls command. ls will return all elements inside the target directory and each file name will be stored in the file_names variable separated by a space
file_names=$(ls "$target_directory") #stores all file names in a string variable

# stores all files names in an array
# IFS (Internal Field Separator) variable: it's a special variable whose value is a delimiter that will be used to split a string
# this will modify the read command to 
IFS=$'\n' # only newlines will be used as separators

# -r: reads 'raw input'. Meaning that it will treat backslaches as literal characters and not scape characters
# -d delimiter: it defines a stopping point. It tells the read command to read the string up to the specified delimiter. For example, if delimiter=' ' the read command will read the files_names string up until the first space ocurrence
# In this case, the delimiter is a null character. Meaning that it will read the string from start to end and won't stop at spaces or endlines
# -a files: stores the split words in the array called files
# <<<: this is a 'here string'. It's a way of passing a string to a command
read -r -d '' -a files <<< "${file_names}"

## Iterate over the files in the array
for file in "${files[@]}";
do
    # Checks if the file belongs to a specific extension and moves it to its respective directory
    
    # Pictures
    if [[ "${file}" == *.png  || "${file}" == *.jpg || "${file}" == *.jpeg ]]; then
        mv "${file}" "${target_directory}\Pictures"
    fi

    # Documents
    if [[ "${file}" == *.pdf || "${file}" == *.doc || "${file}" == *.docx || "${file}" == *.md || "${file}" == *.txt ]]; then
        mv "${file}" "${target_directory}\Documents"
    fi

    # Videos
    if [[ "${file}" == *.mp4 || "${file}" == *.mkv || "${file}" == *.avi || "${file}" == *.mov ]]; then
        mv "${file}" "${target_directory}\Videos"
    fi
    
    # Music
    if [[ "${file}" == *.mp3 || "${file}" == *.wav || "${file}" == *.flac ]]; then
        mv "${file}" "${target_directory}\Music"
    fi

    # Archives
    if [[ "${file}" == *.zip || "${file}" == *.tar || "${file}" == *.gz || "${file}" == *.7z ]]; then
        mv "${file}" "${target_directory}\Archives"
    fi
    
done
