#!/bin/bash

# Define constants for cleaner path handling
declare -r SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
declare -r HOME_DIR="$HOME"
declare -r CONFIG_DIR="$HOME_DIR/.config"
declare -r TMUX_DIR="$CONFIG_DIR/tmux"
declare -r TMUX_CONF="$HOME_DIR/.tmux.conf"
declare -r TMUX_PLUGINS_DIR="$HOME_DIR/.tmux/plugins"

# Old configurations that need to be cleaned
declare -a OLD_CONFIG_DIRS=(
    "$CONFIG_DIR/nvim"
    "$HOME_DIR/.local/share/nvim"
    "$CONFIG_DIR/vscode"
    "$CONFIG_DIR/.git"
    "$TMUX_DIR"
)

# Function to clean old configurations
clean_old_configs() {
    echo "Cleaning up old configurations..."

    for dir in "${OLD_CONFIG_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            echo "Removing directory: $dir"
            rm -rf "$dir"
        fi
    done
}

# Function to set up tmux
setup_tmux() {
    echo "Setting up tmux..."

    local source_file="$SCRIPT_DIR/tmux/tmux.conf"

    if [ ! -f "$source_file" ]; then
        echo "Error: Source file $source_file does not exist."
        exit 1
    fi

    if [ -d "$TMUX_PLUGINS_DIR" ]; then
        echo "Removing existing Tmux plugins directory."
        rm -rf "$TMUX_PLUGINS_DIR"
    fi

    cp "$source_file" "$TMUX_CONF"
    echo "Tmux configuration updated successfully."
}

# Function to handle the final steps of the setup
final_setup_steps() {
    echo "Finalizing setup..."

    # Move new configuration files from the temp directory
    if [ -d "$SCRIPT_DIR" ]; then
        echo "Moving new configuration files to $CONFIG_DIR"
        mv "$SCRIPT_DIR"/* "$SCRIPT_DIR"/.[!.]* "$CONFIG_DIR"
    else
        echo "Error: Temporary configuration directory does not exist."
        exit 1
    fi

    # Cleanup temp directory
    if [ -d "$SCRIPT_DIR" ]; then
        echo "Cleaning up temporary directory."
        rm -rf "$SCRIPT_DIR"
    fi

    echo "Setup completed successfully."
}

# Main script execution
main() {
    clean_old_configs
    setup_tmux
    final_setup_steps
}

# Invoke the script
main
