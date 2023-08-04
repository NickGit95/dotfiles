-- General settings
local options = {
  backup = false,
  hidden = true,
  incsearch = true,
  laststatus = 2,
  number = true,
  relativenumber = true,
  shiftwidth = 4,
  smartindent = true,
  swapfile = false,
  termguicolors = true,
}
local set = vim.opt
for k, v in pairs(options) do
  set[k] = v
end

local lightlineopt = { colorscheme = "dracula", }
vim.api.nvim_set_var("lightline", lightlineopt)

vim.cmd [[
  syntax enable
  imap jj <Esc>
  set iskeyword+=-
  colorscheme dracula
  autocmd BufWritePre * :%s/\s\+$//e
]]
