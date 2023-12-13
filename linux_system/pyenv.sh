#!/bin/bash

# Default configuration
DEFAULT_PYTHON_VERSION="3.12.0"

# Utility functions

# Check if a command exists
command_exists() {
    command -v "$@" >/dev/null 2>&1
}

# Function to print the execution time
print_execution_time() {
    local script_name=$1
    local start_time=$2
    local end_time=$3
    local elapsed_time=$((end_time - start_time))
    echo "Script [$script_name] completed in $elapsed_time seconds."
}

# Function to install pyenv dependencies
install_pyenv_dependencies() {
    sudo apt update
    sudo apt install -y make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
}

# Function to install pyenv
install_pyenv() {
    curl https://pyenv.run | bash
}

# Function to configure pyenv in the shell
configure_pyenv() {
    { 
      echo 'export PYENV_ROOT="$HOME/.pyenv"'
      echo 'export PATH="$PYENV_ROOT/bin:$PATH"'
      echo 'eval "$(pyenv init --path)"'
    } >> ~/.bashrc
    source ~/.bashrc
}

# Function to install Python using pyenv
install_python_with_pyenv() {
    local python_version=$1

    # Update pyenv and install the specified Python version
    pyenv update
    pyenv install $python_version

    # Set the global Python version
    pyenv global $python_version
}

# Main function
main() {
    local python_version=${1:-$DEFAULT_PYTHON_VERSION}

    # Validate Python version (Optional: Implement your own validation logic)

    START_TIME=$SECONDS
    ORIGINAL_DIR=$(pwd)

    # Execute the functions
    install_pyenv_dependencies
    install_pyenv
    configure_pyenv
    install_python_with_pyenv $python_version

    # Clean up and final steps
    cd "$ORIGINAL_DIR"

    END_TIME=$SECONDS
    print_execution_time "$(basename "$0")" $START_TIME $END_TIME
    
    # Source .bashrc to update the current shell environment
    source ~/.bashrc

    # Check Python version
    if command_exists python; then
        python -V
    else
        echo "Python installation not found. You might need to restart your shell."
    fi

    # Restart the shell for PATH updates (optional)
    exec bash
}

# Execute main function with provided arguments
main $1

