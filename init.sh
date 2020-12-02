#!/usr/bin/env bash
set -xeuo pipefail

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

# replace source.list
apt update && apt install -y lsb-release && apt clean all

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

apt update && apt install -y vim git zsh curl wget python3 python3-pip tmux build-essential cmake python3-dev ctags silversearcher-ag clang-format clang gdb && apt clean all

# install go
go_version=$(curl 'https://golang.org/VERSION?m=text')

wget "https://dl.google.com/go/$go_version.linux-amd64.tar.gz"

tar -C /usr/local -xzf $go_version.linux-amd64.tar.gz

rm $go_version.linux-amd64.tar.gz

sudo -u $real_user bash -c "$(curl -fsSl https://raw.githubusercontent.com/Lasorda/init-tool/main/init_user.sh)"
