#!/bin/bash

# -z: checks if a string is empty. Returns true if it is. In this case, it's checking if a directory path was provided as an argument
# if the directory string is empty, it means that we will work in the pwd (the default directory), else we will work in the specified directory

start_time=$(date +%s)

if [ -z $1 ]; then
    # We store the path of the current directory
    target_directory=$(pwd)
else
    # We store the directory path provided as an argument
    target_directory=$1
fi

# Create file folders in the target directory
cd "${target_directory}"

# declares an associative array (key-value pairs)
declare -A categories

# read valid file extensions from categories.conf file
while IFS='=' read -r category extensions_str; do

    # =~ : this is used for regular expression matching
    # && (double ampersand), in this case, is used for command chaining not a logical AND operation.
    # This means that if the condition success (is true), then the && statement will execute 
    # this condition checks if the line is a comment or is empty . if it is, it skips it
    [[ "${category}" =~ ^# || -z "${category}" ]] && continue

    # creates directory if it doesn't exist
    # the -p flag tells the mkdir command to ignore errors if the directory already exists. Meaning that it won't overwrite the directory nor stop the program due to the 'File exists' error. If the directory doesn't exist, then it will create it as usual.
    mkdir -p "${category}"

    # xargs removes leading and trailing whitespaces and newlines. It also collapses multiple adjecent spaces into a single space
    extensions_str=$(echo "${extensions_str}" | xargs)
    categories["${category}"]="${extensions_str}"

done < "/config/categories.conf"

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
for file in "${files[@]}"; do
    
    # Iterates through all categories
    for category in "${!categories[@]}"; do

        # stores the categories' file extensions in an array
        IFS=',' read -r -a file_extensions <<< "${categories[${category}]}"

        # finds to which file extension category a file belongs to
        for ext in "${file_extensions[@]}"; do
        
            if [[ "${file}" =~ \.("${ext}")$ ]]; then
                mv "${file}" "${target_directory}\\${category}"
            fi

        done
    
    done
    
done

# date: returns the current date 
# +%s: tells it to return the date in seconds
# There are multiple opitons such as %Y (for year) or %m (for month)
end_time=$(date +%s)
# double parentheses (( )) are used for arithmetic operations
duration=$(( end_time - start_time ))
echo "Execution time: ${duration} seconds"