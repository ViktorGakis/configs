#!/bin/bash

# Set the base directories
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
CONFIG_DIR="$HOME/.config"
PLUGINS_DIR="$HOME/.tmux/plugins/"

# Paths for the tmux configuration
SOURCE_FILE="$BASE_DIR/tmux/tmux.conf"
DESTINATION_FILE="$HOME/.tmux.conf"

# Remove specific directories
cleanup() {
    echo "Cleaning up existing configuration directories..."

    # Directories to remove. Note that these are absolute paths.
    local dirs=( 
        "$HOME/.config_temp" 
        "$HOME/.config/nvim" 
        "$HOME/.local/share/nvim" 
        "$HOME/.config/vscode" 
        "$HOME/.config/.git"  # This was previously incorrectly specified without the leading dot
        "$HOME/.config/tmux" 
    )

    for dir_path in "${dirs[@]}"; do
        if [ -d "$dir_path" ]; then
            echo "Removing $dir_path"
            rm -rf "$dir_path"
            if [ $? -ne 0 ]; then
                echo "Error: Could not remove $dir_path"
                exit 1
            fi
        else
            echo "Directory $dir_path does not exist, skipping."
        fi
    done

    # Handling the tmux plugins directory separately as it's not in the .config directory
    if [ -d "$PLUGINS_DIR" ]; then
        echo "Removing $PLUGINS_DIR"
        rm -rf "$PLUGINS_DIR"
        if [ $? -ne 0 ]; then
            echo "Error: Could not remove $PLUGINS_DIR"
            exit 1
        fi
    fi
}


# Setup tmux configuration
setup_tmux() {
    echo "Setting up tmux..."

    # Check if the tmux.conf source file exists
    if [ ! -f "$SOURCE_FILE" ]; then
        echo "Error: Source file $SOURCE_FILE does not exist."
        exit 1
    fi

    # Create or truncate the destination file
    : > "$DESTINATION_FILE"

    # Replace 'TERM_VALUE' with the actual $TERM value in the source file
    local current_term=$TERM
    sed "s/TERM_VALUE/$current_term/g" "$SOURCE_FILE" > "$DESTINATION_FILE"

    if [ $? -ne 0 ]; then
        echo "Error: Could not set up tmux configuration."
        exit 1
    fi

    echo "Tmux configuration updated successfully."
}

# Move the cloned configuration to the appropriate directory
move_configuration() {
    echo "Moving new configuration..."

    # Avoid overwriting the entire .config directory by using rsync or moving specific subdirectories
    rsync -avh --ignore-existing "$BASE_DIR/" "$CONFIG_DIR/" --exclude setup.sh

    if [ $? -ne 0 ]; then
        echo "Error: Could not move the new configuration."
        exit 1
    fi
}

# Main script execution
main() {
    cleanup
    setup_tmux
    move_configuration

    echo "Configuration applied successfully."
}

# Invoke the script
main
