-- General settings
vim.opt.formatoptions:remove({ "c", "r", "o" })
local o = vim.o

o.backup = false
o.cursorline = true
o.cursorlineopt = "number"
o.expandtab = true
o.hidden = true
o.incsearch = true
o.laststatus = 2
o.number = true
o.numberwidth = 4
o.ruler = false
o.shiftwidth = 4
o.showmode = false
o.smartindent = true
o.softtabstop = 4
o.swapfile = false
o.tabstop = 4
o.termguicolors = true

vim.cmd([[
    colorscheme eldritch
    syntax on
    imap jj <Esc>
    set iskeyword+=-
]])
