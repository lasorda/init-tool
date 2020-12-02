#!/usr/bin/env bash
set -xeuo pipefail

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" <<< Y

# install go
go env -w GOPATH="$HOME/.go"

echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.zshrc

# install rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

source ~/.cargo/env

# install python3 and ipython
echo "export PATH=$PATH:~/.local/bin" >> ~/.zshrc

# install tmux
curl -fLo ~/.tmux.conf https://gist.githubusercontent.com/Lasorda/781d5dc339a0e6392482a95250b95f02/raw/ec7523bc603dccdd945b4bb8b6da81312f1e67f9/.tmux.conf

echo "[ -z "$TMUX"  ] && [ -n "$SSH_CONNECTION"  ] && { tmux attach || exec tmux new-session && exit;  }" >> ~/.zshrc

# config vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.vimrc https://raw.githubusercontent.com/Lasorda/vimrc/master/.vimrc

vim -c "PlugInstall" -c "q" -c "q"

vim -c "GoInstallBinaries" -c "q" -c "q"
