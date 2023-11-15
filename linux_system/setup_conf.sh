#!/bin/sh

# Function to print the execution time
print_execution_time() {
    local script_name=$1
    local start_time=$2
    local end_time=$3
    local elapsed_time=$((end_time - start_time))
    echo "Script [$script_name] completed in $elapsed_time seconds."
}

setup_conf() {

    [ -d ~/.config_temp/ ] && sudo rm -rf ~/.config_temp/

    git clone --depth 1 https://github.com/ViktorGakis/dotfiles.git ~/.config_temp/

    bash ~/.config_temp/setup.sh
}

main() {
    START_TIME=$SECONDS
    setup_conf
    END_TIME=$SECONDS
    print_execution_time "$(basename "$0")" $START_TIME $END_TIME

    exec bash
}

main
