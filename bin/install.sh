my_dir=$(cd $(dirname $0) && pwd)
shell_type=$1

install_bash() {
    $my_dir/../bash-it/install.sh
    if [ -e ~/.bashrc ]; then
        mv ~/.bashrc ~/.bashrc_backup
    fi
    echo 'source ~/env/.bashrc' > ~/.bashrc
    source ~/.bashrc
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


