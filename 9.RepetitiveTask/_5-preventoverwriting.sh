#!/bin/bash

# check if the target file name already exists before attempting to rename the file.

LIST="$(ls)"
for name in $LIST; do
    if [[ "$name" != *[[:upper:]]* ]]; then
        continue
    fi

    ORIG="$name"
    NEW=$(echo "$name" | tr 'A-Z' 'a-z')

    if [[ -e "$NEW" ]]; then
        echo "File $NEW already exists. Skipping $ORIG."
    else
        mv "$ORIG" "$NEW"
        echo "new name for $ORIG is $NEW"
    fi
done