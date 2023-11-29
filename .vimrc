"vim 的主配置文件
"在 vim 环境中如何直接打开此文件？
"在命令模式下执行 :e $MYVIMRC
set nocompatible
filetype off

"$MYVIMRUNTIME 变量是一个自定义的shell 变量
"由shell 脚本定义
"VimR
if has("gui_running")
    let $MYVIMRUNTIME = '~/env/vim'
endif

"rtp 是 runtimepath 的缩写，如何显示其值？
"在命令模式下执行 :set rtp?
let &rtp=$MYVIMRUNTIME.','.&rtp

if has("gui_running")
    source $MYVIMRUNTIME/plugin-vimr.vim
el
    if !exists('g:vscode')
        source $MYVIMRUNTIME/plugin.vim
    en
en

filetype plugin indent on    " required

if has("gui_running")
    set termguicolors
el
    if !has("nvim")
        set term=xterm-256color
    en
en

if !exists('g:vscode')
    set background=dark
    syntax enable
    let g:solarized_termcolors=256
    colorscheme solarized
    let g:airline#extensions#tabline#enabled=1
en

set hls
set incsearch
set et
set ts=4
set sw=4
set nu
set ffs=unix,dos,mac

set fdm=marker
set foldmarker=[[[,]]]

"status line
set laststatus=2
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

map <C-N> :NERDTreeToggle<CR>

set modeline
