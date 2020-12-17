"VimR 专用
"vim-plug 的配置文件
call plug#begin('~/.vim/plugged')

" theme 不同于term 版
Plug 'frankier/neovim-colors-solarized-truecolor-only'

" functionality
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'

call plug#end()
