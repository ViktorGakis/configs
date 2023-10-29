#!/bin/bash

# Define the file paths
SOURCE_FILE="./tmux/tmux.conf"
DESTINATION_FILE="$HOME/.tmux.conf"
PLUGINS_DIR="$HOME/.tmux/plugins/"

# Fetch the current $TERM value
CURRENT_TERM=$TERM

[ -d ~/.config_temp/ ] && rm -rf ~/.config_temp/
[ -d ~/.config/nvim/ ] && rm -rf ~/.config/nvim/
[ -d ~/.local/share/nvim/ ] && rm -rf ~/.local/share/nvim/
[ -d ~/.config/vscode/ ] && rm -rf ~/.config/vscode/
[ -d ~/.config/.git ] && rm -rf ~/.config/.git
[ -d ~/.config/tmux/ ] && rm -rf ~/.config/tmux/

# Clone the entire repo directly into ~/.config
[ -d ~/.config_temp/ ] && rm -rf ~/.config_temp/
git clone --depth 1 https://github.com/ViktorGakis/dotfiles.git ~/.config_temp/

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

# Replace 'TERM_VALUE' with the actual $TERM value in the source file and write it to the destination file
sed "s/TERM_VALUE/$CURRENT_TERM/g" "$SOURCE_FILE" > "$DESTINATION_FILE"

echo "Tmux configuration updated successfully."

# Move all the content from the temp cloned directory to ~/.config+
mkdir -p ~/.config/
mv ~/.config_temp/* ~/.config_temp/.[!.]* ~/.config/

# Remove the temporary directory
rm -rf ~/.config_temp/
