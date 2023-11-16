#!/bin/bash

# Ensure that npm is installed
if ! command -v npm &>/dev/null; then
    echo "npm could not be found. Please install npm first."
    exit
fi

# Install 'n', a node version manager. The '-g' flag indicates that it will be installed globally.
sudo npm install -g n

# Install the latest stable version of Node.js
sudo n stable

# Install 'create-react-app' globally. It's a Node.js module used to create new React applications.
sudo npm install -g create-react-app

# Echo a successful message
echo "Installation completed successfully."
