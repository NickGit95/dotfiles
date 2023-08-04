-- Plugin installation
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')

Plug 'dracula/vim'
Plug 'itchyny/lightline.vim'

vim.call('plug#end')
