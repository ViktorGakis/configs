#!/bin/bash

# Set up global variables
SOURCE_FILE="./tmux/tmux.conf"
DESTINATION_FILE="$HOME/.tmux.conf"
PLUGINS_DIR="$HOME/.tmux/plugins/"
REPO_URL="https://github.com/ViktorGakis/dotfiles.git"
TEMP_DIR="$HOME/.config_temp/"
CONFIG_DIR="$HOME/.config/"

# Cleans up the old configuration
cleanup_old() {
    local dirs_to_remove=("$CONFIG_DIR/nvim/" "$CONFIG_DIR/vscode/" "$CONFIG_DIR/.git" "$CONFIG_DIR/tmux/" "$PLUGINS_DIR" "$TEMP_DIR")

    echo "Cleaning up old configuration..."
    for dir in "${dirs_to_remove[@]}"; do
        if [ -d "$dir" ]; then
            rm -rf "$dir"
        fi
    done
}

# Clone new configuration
clone_new() {
    echo "Cloning new configuration..."
    if ! command -v git &>/dev/null; then
        echo "Error: git is not installed."
        exit 1
    fi

    git clone --depth 1 "$REPO_URL" "$TEMP_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to clone repository."
        exit 1
    fi
}

# Check and setup tmux configuration
setup_tmux() {
    echo "Setting up tmux..."

    if [ ! -f "$SOURCE_FILE" ]; then
        echo "Error: Source file $SOURCE_FILE does not exist."
        exit 1
    fi

    # Ensure destination exists and is empty
    cat /dev/null > "$DESTINATION_FILE"

    local current_term=$TERM
    sed "s/TERM_VALUE/$current_term/g" "$SOURCE_FILE" > "$DESTINATION_FILE"
    if [ $? -ne 0 ]; then
        echo "Error: Could not set up tmux configuration."
        exit 1
    fi

    echo "Tmux configuration updated successfully."
}

# Move new configuration into place
move_configuration() {
    echo "Moving new configuration into place..."

    mkdir -p "$CONFIG_DIR"
    # The dot at the end of the source path is important to copy hidden files
    cp -r "$TEMP_DIR". "$CONFIG_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Could not move new configuration."
        exit 1
    fi

    # Clean up temp directory
    rm -rf "$TEMP_DIR"
}

# Main script logic
main() {
    cleanup_old
    clone_new
    setup_tmux
    move_configuration

    echo "All configurations have been successfully updated."
}

# Start the script
main

