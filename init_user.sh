#!/usr/bin/env bash
set -xeuo pipefail

# install go
PATH=$PATH:/usr/local/go/bin

go env -w GOPATH="$HOME/.go"

# install rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

source ~/.cargo/env

pip3 install ipython

PATH=$PATH:~/.local/bin

# install tmux
curl -fLosS ~/.tmux.conf https://gist.githubusercontent.com/Lasorda/781d5dc339a0e6392482a95250b95f02/raw/ec7523bc603dccdd945b4bb8b6da81312f1e67f9/.tmux.conf

# config vim
curl -fLosS ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLosS ~/.vimrc https://raw.githubusercontent.com/Lasorda/vimrc/master/.vimrc

vim -c "PlugInstall" -c "q" -c "q"

vim -c "GoInstallBinaries" -c "q" -c "q"

cp ~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py ~/.vim/

# fix cpp
sed -i "/.*pybind11/a'-isystem',\n'/usr/include/c++/9'," ~/.vim/.ycm_extra_conf.py

# install oh my zsh final
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "export PATH=\$PATH:/usr/local/go/bin:~/.local/bin" >> ~/.zshrc

echo "[ -z \"\$TMUX\"  ] && [ -n \"\$SSH_CONNECTION\"  ] && { tmux attach || exec tmux new-session && exit;  }" >> ~/.zshrc
