#!/bin/bash

if ! command -v rustup &> /dev/null
then
    echo "rustup command could not be found. Install Rust via rustup and try running this script again."
    exit
fi

# Only works for Ubuntu 18.04+
sudo apt install neovim
sudo apt install python-neovim
sudo apt install python3-neovim
# alt:
# pip3 install neovim pynvim

rustup component add clippy
rustup component add rustfmt
rustup component add rust-src


# https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary
git clone https://github.com/rust-analyzer/rust-analyzer.git && cd rust-analyzer
cargo xtask install --server
cd ..
rm -rf rust-analyzer

# LSD install
cargo install lsd


# Install Plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
