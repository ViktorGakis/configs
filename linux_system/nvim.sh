#!/bin/sh

# Function to print the execution time
print_execution_time() {
    local script_name=$1
    local start_time=$2
    local end_time=$3
    local elapsed_time=$((end_time - start_time))
    echo "Script [$script_name] completed in $elapsed_time seconds."
}

# Utility function to install rust and cargo
# install [cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html)
install_rust_and_cargo() {
    echo "Installing rust and cargo..."
    curl https://sh.rustup.rs -sSf | sh
    source $HOME/.cargo/env
}

# Utility function to install fd-find using cargo
# install https://github.com/sharkdp/fd
install_fd_find() {
    echo "Installing fd-find..."
    cargo install fd-find
}

install_tree_sitter_cli() {
    echo "Installing Tree-sitter-CLI"
    cargo install tree-sitter-cli
}

# Utility function to install ripgrep directly from releases
# install [ripgrep](https://github.com/BurntSushi/ripgrep/releases/) directly from releases (this worked)
install_ripgrep_from_releases() {
    local RG_VERSION="13.0.0"
    echo "Installing ripgrep version ${RG_VERSION}..."
    curl -LO "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
    tar xf ripgrep-${RG_VERSION}-*.tar.gz
    mkdir -p $HOME/bin
    cp ripgrep-${RG_VERSION}-*/rg $HOME/bin/rg
    rm -rf ripgrep-${RG_VERSION}-*
}

# Utility function to install Neovim from source
install_neovim_from_source() {
    echo "Installing Neovim from source..."
    git clone https://github.com/neovim/neovim.git /tmp/neovim
    cd /tmp/neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    sudo rm -rf /tmp/neovim
}

main() {
    START_TIME=$SECONDS
    install_rust_and_cargo
    install_fd_find
    install_ripgrep_from_releases
    install_tree_sitter_cli
    install_neovim_from_source

    END_TIME=$SECONDS
    print_execution_time "$(basename "$0")" $START_TIME $END_TIME

    exec bash
}

main

# install [ripgrep](https://github.com/BurntSushi/ripgrep) from source

# git clone https://github.com/BurntSushi/ripgrep.git
# cd ripgrep
# cargo build --release
# ./target/release/rg -V

# docker command equivalent
# Build and Install Neovim from source
# RUN git clone https://github.com/neovim/neovim.git /tmp/neovim && \
#     cd /tmp/neovim && \
#     make CMAKE_BUILD_TYPE=RelWithDebInfo && \
#     make install && \
#     rm -rf /tmp/neovim
