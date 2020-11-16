#!/bin/bash

export SECRET_DIR=$1
export SRC_DIR=$2



echo "Loading secrets from $SECRET_DIR"
echo "Writing to $SRC_DIR"

FILES="$SECRET_DIR/*"

for f in $FILES
do
    FILE_PATH=$(cat $f | jq -r '.dirName')
    echo "Creating directory $FILE_PATH"
    mkdir -p $SRC_DIR/$FILE_PATH
    FULL_FILE_PATH=$SRC_DIR/$FILE_PATH/$(cat $f | jq -r '.fileName')
    echo "Creating file $FULL_FILE_PATH"
    cat $f | jq -r '.data' | base64 -d > $FULL_FILE_PATH 
done