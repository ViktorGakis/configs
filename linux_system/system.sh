#!/bin/bash

print_execution_time() {

    local script_name=$1
    local start_time=$2
    local end_time=$3
    local elapsed_time=$((end_time - start_time))
    echo "Script [$script_name] completed in $elapsed_time seconds."

}

install_packages() {

    sudo apt-get update --fix-missing &&
        sudo apt-get -y upgrade &&
        sudo apt-get install -y --no-install-recommends \
            software-properties-common \
            xclip \
            make \
            wget \
            curl \
            unzip \
            git \
            zip \
            tree \
            xz-utils \
            ninja-build \
            gettext \
            libtool \
            libtool-bin \
            autoconf \
            automake \
            cmake \
            g++ \
            nodejs \
            npm \
            default-jre \
            default-jdk \
            tmux \
            net-tools\
            traceroute \
            sudo pkg-config &&
        sudo rm -rf /var/lib/apt/lists/*

}

main() {
    START_TIME=$SECONDS
    install_packages
    END_TIME=$SECONDS
    print_execution_time "$(basename "$0")" $START_TIME $END_TIME
    exec bash
    source /etc/bash_completion
}

main
