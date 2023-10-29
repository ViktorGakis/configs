#!/bin/bash

# Define the file paths
SOURCE_FILE="./tmux/tmux.conf"
DESTINATION_FILE="$HOME/.tmux.conf"
PLUGINS_DIR="$HOME/.tmux/plugins/"

# Check if the plugins directory exists and delete it if it does
if [ -d "$PLUGINS_DIR" ]; then
    echo "Removing existing plugins directory."
    rm -rf "$PLUGINS_DIR"
    if [ $? -ne 0 ]; then  # Check if the 'rm' command encountered any issues
        echo "Error: Could not remove the plugins directory."
        exit 1
    fi
fi

# Check if the source tmux configuration file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Source file $SOURCE_FILE does not exist."
    exit 1
fi

# Replace or create the destination tmux configuration file
if [ -f "$DESTINATION_FILE" ]; then
    # If the destination file exists, empty its contents
    > "$DESTINATION_FILE"
else
    # If the file doesn't exist, create it
    touch "$DESTINATION_FILE"
fi

# Copy the contents from the source file to the destination file
cat "$SOURCE_FILE" > "$DESTINATION_FILE"

echo "Tmux configuration updated successfully."

