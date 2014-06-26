install_bash() {
    if [ -e ~/.bashrc ]; then
        mv ~/.bashrc ~/.bashrc_backup
    fi
    echo 'source ~/env/.bashrc' > ~/.bashrc
    source ~/.bashrc
}

install_bash

install_vim() {
    if [ -e ~/.vimrc ]; then
        mv ~/.vimrc ~/.vimrc_backup
    fi
    ln -s ~/env/.vimrc ~/.vimrc
}

install_vim
