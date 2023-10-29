#!/bin/bash

# Set the temporary directory and repository URL
TEMP_DIR="$HOME/.config_temp"
REPO_URL="https://github.com/ViktorGakis/dotfiles.git"
PLUGINS_DIR="$HOME/.tmux/plugins/"

# Paths for the tmux configuration
SOURCE_FILE="$TEMP_DIR/tmux/tmux.conf"
DESTINATION_FILE="$HOME/.tmux.conf"

# Remove existing configurations
cleanup() {
    echo "Cleaning up existing configuration directories..."
    local dirs=( "$HOME/.config/nvim" "$HOME/.config/vscode" "$HOME/.config/.git" "$HOME/.config/tmux" "$PLUGINS_DIR" "$TEMP_DIR" )

    for dir in "${dirs[@]}"; do
        if [ -d "$dir" ]; then
            rm -rf "$dir"
        fi
    done
}

# Clone the repository
clone_repo() {
    echo "Cloning repository..."
    mkdir -p "$TEMP_DIR"
    git clone --depth 1 "$REPO_URL" "$TEMP_DIR"
}

# Setup tmux
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
    mkdir -p "$HOME/.config"
    mv "$TEMP_DIR"/* "$TEMP_DIR"/.[!.]* "$HOME/.config"  # This line moves hidden files as well
}

# Main script execution
main() {
    cleanup
    clone_repo
    setup_tmux
    move_configuration

    # Final cleanup: Remove the temporary directory if it's still present
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
    fi

    echo "Configuration applied successfully."
}

# Invoke the script
main
