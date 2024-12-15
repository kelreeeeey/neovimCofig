vim.g.mapleader=' '
vim.g.maplocalleader=' '
vim.g.have_nerd_font=true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldcolumn = '0'
vim.opt.foldtext = ''
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.wrap = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'
vim.opt.conceallevel = 1
vim.opt.cursorline = true

vim.opt.scrolloff = 10
vim.opt.spelllang = { 'en,idn' }

vim.o.termguicolors = true
vim.cmd ' let g:netrw_liststyle = 4 '

