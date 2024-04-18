#!/bin/bash

# Check if a directory path is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

directory_path=$1

# Check if the provided path is a directory
if [ ! -d "$directory_path" ]; then
    echo "Error: '$directory_path' is not a valid directory."
    exit 1
fi

echo "Scanning for duplicates in $directory_path..."

# Change to the specified directory
cd "$directory_path"

# Loop through all files in the specified directory
for file in *; do
    if [[ -f "$file" ]]; then
        # Check if a duplicate with a ' 2' suffix exists
        duplicate="${file%.*} 2.${file##*.}"
        if [[ -f "$duplicate" ]]; then
            echo "Duplicate found: $duplicate"
            # Ask user if they want to delete the duplicate
            read -p "Do you want to delete this file? (y/n) " answer
            case $answer in
                [Yy]* ) rm "$duplicate"; echo "$duplicate deleted.";;
                [Nn]* ) echo "Kept $duplicate.";;
                * ) echo "Invalid response. No action taken.";;
            esac
        fi
    fi
done

echo "Duplicate scan complete."
