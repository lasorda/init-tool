#!/usr/bin/env bash
set -xeuo pipefail

# replace source.list

apt-get update && apt-get install -y lsb-release && apt-get clean all

echo "
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
" > /etc/apt/sources.list

sed -i "s/focal/$(lsb_release -c -s)/" /etc/apt/sources.list

apt update

apt install vim git -yq

# install zsh
apt install zsh curl wget -yq

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" <<< Y

# install go
go_version=$(curl 'https://golang.org/VERSION?m=text')

wget "https://dl.google.com/go/$go_version.linux-amd64.tar.gz"

tar -C /usr/local -xzf $go_version.linux-amd64.tar.gz

PATH=$PATH:/usr/local/go/bin

go env -w GOPATH="$HOME/.go"

echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.zshrc

rm $go_version.linux-amd64.tar.gz

# install rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

source $HOME/.cargo/env

# install python3 and ipython
apt install python3 python3-pip -yq

pip3 install ipython

PATH=$PATH:~/.local/bin

echo "export PATH=$PATH:~/.local/bin" >> ~/.zshrc

# install tmux
apt install tmux -yq

curl -fLo ~/.tmux.conf https://gist.githubusercontent.com/Lasorda/781d5dc339a0e6392482a95250b95f02/raw/ec7523bc603dccdd945b4bb8b6da81312f1e67f9/.tmux.conf

echo "[ -z "$TMUX"  ] && [ -n "$SSH_CONNECTION"  ] && { tmux attach || exec tmux new-session && exit;  }" >> ~/.zshrc

# config vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.vimrc https://raw.githubusercontent.com/Lasorda/vimrc/master/.vimrc

apt install build-essential cmake python3-dev ctags silversearcher-ag clang-format clang -yq

vim -c "PlugInstall" -c "q" -c "q"

vim -c "GoInstallBinaries" -c "q" -c "q"

