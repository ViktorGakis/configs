#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$@" >/dev/null 2>&1
}

# Ensure that npm is installed
if ! command_exists npm; then
    echo "npm could not be found. Please install npm first."
    exit 1
fi

echo "Installing 'n', a Node.js version manager..."
# Install 'n', a node version manager. The '-g' flag indicates that it will be installed globally.
sudo npm install -g n

# Check if 'n' installed successfully
if ! command_exists n; then
    echo "'n' installation failed. Exiting."
    exit 1
fi

echo "Installing the latest stable version of Node.js..."
# Install the latest stable version of Node.js
sudo n stable

# Check if Node.js installed successfully
if ! command_exists node; then
    echo "Node.js installation failed. Exiting."
    exit 1
fi

echo "Installing Vite..."
# Install vite globally. It's a Node.js module used to create new React applications.
sudo npm install -g vite

# Check if Vite installed successfully
if ! command_exists vite; then
    echo "Vite installation failed. Exiting."
    exit 1
fi

# Echo a successful message
echo "Vite has been installed successfully."

