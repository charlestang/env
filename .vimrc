let &rtp=$MYVIMRUNTIME.','.&rtp
execute pathogen#infect()
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

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

set modeline
