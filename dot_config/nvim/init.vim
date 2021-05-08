"""""""""""""""""""""""""""
"               _         "
"   ____ _   __(_)___ ___ "
"  / __ \ | / / / __ `__ \"
" / / / / |/ / / / / / / /"
"/_/ /_/|___/_/_/ /_/ /_/ "
"""""""""""""""""""""""""""

" General settings
set number relativenumber
set shiftwidth=4
set t_Co=256
syntax enable

" Map jj to Esc
imap jj <Esc>

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Begin plug install
call plug#begin(stdpath('data') . '/plugged')
Plug 'dracula/vim'
Plug 'itchyny/lightline.vim'

" Initialize plugin system
call plug#end()

" Set the color scheme
"let g:dracula_colorterm = 0 " Uncomment to remove background color
let g:lightline = {
  \ 'colorscheme': 'darcula',
  \ }
set termguicolors
colorscheme dracula

" Always show statusline
set laststatus=2

" Delete trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
