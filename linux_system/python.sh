#!/bin/bash

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

# Function to install required dependencies
install_dependencies() {
    sudo apt-get update
    sudo apt-get install -y \
        gdebi-core \
        curl \
        gcc \
        libbz2-dev \
        libev-dev \
        libffi-dev \
        libgdbm-dev \
        liblzma-dev \
        libncurses-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libgdbm-compat-dev \
        make \
        tk-dev \
        wget \
        zlib1g-dev
}

# Function to download, compile, and install Python
install_python() {
    local PYTHON_VERSION=$1

    # download
    curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
    tar -xvzf Python-${PYTHON_VERSION}.tgz
    cd Python-${PYTHON_VERSION}

    # build and install
    ./configure \
        --prefix=/opt/python/${PYTHON_VERSION} \
        --enable-shared \
        --enable-optimizations \
        --enable-ipv6 \
        LDFLAGS=-Wl,-rpath=/opt/python/${PYTHON_VERSION}/lib,--disable-new-dtags
    make
    sudo make install
}

# Function to install pip for the new Python installation
install_pip() {
    local PYTHON_VERSION=$1

    curl -O https://bootstrap.pypa.io/get-pip.py
    sudo /opt/python/${PYTHON_VERSION}/bin/python3 get-pip.py
}

# Function to adjust PATH for the new Python installation
adjust_path() {
    local PYTHON_VERSION=$1

    PYTHON_PATH="/opt/python/${PYTHON_VERSION}/bin/python3"

    # Check if the python version exists at the specified path
    if [ ! -f "$PYTHON_PATH" ]; then
        echo "Error: $PYTHON_PATH does not exist."
        return 1
    fi

    # Create a directory for custom binaries if it doesn't exist
    mkdir -p ~/bin

    # Update the PATH variable to include the custom bin directory
    grep -qxF 'export PATH="$HOME/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/bin:$PATH"' >>~/.bashrc

    # Update the PATH for the current session
    export PATH="$HOME/bin:$PATH"

    # Link 'python' if it doesn't exist or if it's not pointing to the new installation
    if [ ! -e ~/bin/python ] || [ "$(readlink ~/bin/python)" != "$PYTHON_PATH" ]; then
        ln -sf $PYTHON_PATH ~/bin/python
    fi

    # Link 'python3' if it doesn't exist or if it's not pointing to the new installation
    if [ ! -e ~/bin/python3 ] || [ "$(readlink ~/bin/python3)" != "$PYTHON_PATH" ]; then
        ln -sf $PYTHON_PATH ~/bin/python3
    fi

    # Make the new symbolic links executable
    sudo chmod +x ~/bin/python
    sudo chmod +x ~/bin/python3
}

# Main
main() {
    START_TIME=$SECONDS

    ORIGINAL_DIR=$(pwd)

    local PYTHON_VERSION=${1:-3.12.0}

    if ! command_exists curl; then
        echo "Error: curl is not installed."
        exit 1
    fi

    install_dependencies
    install_python $PYTHON_VERSION
    install_pip $PYTHON_VERSION
    adjust_path $PYTHON_VERSION

    cd "$ORIGINAL_DIR"
    sudo rm -rf Python-${PYTHON_VERSION}
    sudo rm -f Python-${PYTHON_VERSION}.tgz

    echo "Python ${PYTHON_VERSION} installation and PATH adjustment completed!"
    END_TIME=$SECONDS
    print_execution_time "$(basename "$0")" $START_TIME $END_TIME
    /opt/python/${PYTHON_VERSION}/bin/python3 --version

    # restart the shell for PATH updates
    exec bash

}

# Calling main function with argument
main $1
