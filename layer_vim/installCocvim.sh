#!/bin/bash

export http_proxy=http://10.78.92.79:58088
export https_proxy=https://10.78.92.79:58088

sudo chown -R lxy ${HOME}

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo apt update && sudo apt install exuberant-ctags -y && sudo apt clean

#vim +PlugInstall +qall

unset http_proxy && unset https_proxy
