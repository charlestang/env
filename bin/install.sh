#!/bin/bash
my_dir=$(cd $(dirname $0) && pwd)
shell_type=$1

if [ -z $shell_type ]; then
    echo Usage: $0 "<shell_name>"
    echo "<shell_name>" could be zsh or bash
    exit
fi 

source $my_dir/../.global_export

install_bash() {
    $my_dir/../bash-it/install.sh
    if [ $platform = "Darwin" ]; then
        if [ -e ~/.bashrc ]; then
            mv ~/.bashrc ~/.bashrc_backup
        fi
        echo 'source ~/env/.bashrc' > ~/.bashrc
        echo 'source ~/.bash_profile' >> ~/.bashrc
    else
        echo 'source ~/env/.bashrc' >> ~/.bashrc
    fi
    install_vim
}

install_vim() {
    if [ -e ~/.vimrc ]; then
        mv ~/.vimrc ~/.vimrc_backup
    fi
    ln -s ~/env/.vimrc ~/.vimrc
}

cmd=install_$shell_type
$cmd


