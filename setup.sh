#! /bin/bash
# run headless nvim and install plugins

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install plugins
nvim --headless +PackerInstall +qall

# install non-plugin dependencies
# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# install ripgrep
cargo install ripgrep
# add rust to path
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
