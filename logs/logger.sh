#!/bin/bash

mkdir -p "./logs"
log_file="./logs/organize-files.log"
# touch will create the file if it doesn't exist, and if it already exists, it won't clear its content
# -a: updates only the access time, not the modification time
touch -a "${log_file}"

log_event() {
    # $1: toma el argumento con el que se llama a esta función
    # tee: agrega el output a un archivo y lo muestra en la consola al mismo tiempo
    # -a: append
    echo "$(date +%Y/%m/%d' '%T) $1" | tee -a "${log_file}"
}

script_start() {
    log_event "Script started"
}

script_target_directory() {
   log_event "Target directory set to '$1'"
}

script_end() {
    log_event "Script finished after $1 seconds"
}