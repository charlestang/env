#!/bin/bash
ROOTPATH=$(cd $(dirname $0) && pwd)
PLATFORM=$(uname)

source $ROOTPATH/.global_export
shell_type=$1

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

install_rzsz() {
    # 检查文件是否存在
    if [ ! -e /usr/local/bin/iterm2-recv-zmodem.sh ]; then
        # 文件不存在，创建软链接
        ln -s ~/env/mac/iterm2-zmodem/iterm2-recv-zmodem.sh /usr/local/bin/iterm2-recv-zmodem.sh
    fi 

    if [ ! -e /usr/local/bin/iterm2-send-zmodem.sh ]; then
        # 文件不存在，创建软链接
        ln -s ~/env/mac/iterm2-zmodem/iterm2-send-zmodem.sh /usr/local/bin/iterm2-send-zmodem.sh
    fi 

    echo "Please set trigger on iTerm2 youself!"
    cat ~/env/mac/iterm2-zmodem/README.md
}

cmd=install_$shell_type
$cmd


