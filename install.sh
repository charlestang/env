#!/bin/bash
ROOTPATH=$(cd $(dirname $0) && pwd)
PLATFORM=$(uname)



source $ROOTPATH/.global_export

install_bash() {
    $ROOTPATH/bash-it/install.sh
    if [ $PLATFORM = "Darwin" ]; then
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


