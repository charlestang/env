call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" colore scheme solarized
Plugin 'altercation/vim-colors-solarized'

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
if v:version >= 703
    if has("patch598")
        Plugin 'Valloric/YouCompleteMe'
    en
en

call vundle#end()
