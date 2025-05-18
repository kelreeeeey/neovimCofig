vim.g.mapleader=' '
vim.g.maplocalleader=' '
vim.g.have_nerd_font=true
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = ''
vim.opt.foldnestmax = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'nv' -- Mouse only in normal and viusual mode
vim.opt.showmode = false

vim.o.tabstop = 2 -- Number of spaces a tab represents
vim.o.shiftwidth = 2 -- Number of spaces for each indentation
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.smartindent = true -- Automatically indent new lines
vim.o.smarttab = true -- Automatically indent new lines

vim.opt.foldmethod = "expr"

vim.o.foldcolumn = "auto" -- '0' is not bad
vim.o.foldlevel = 49 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 1 -- 99
vim.o.foldenable = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '→ ', trail = '|', nbsp = '␣' }

vim.opt.inccommand = 'split'
vim.opt.conceallevel = 1
vim.opt.cursorline = true

vim.opt.scrolloff = 10
vim.opt.spelllang = { 'en,idn' }

vim.o.termguicolors = true
vim.cmd ' let g:netrw_liststyle = 4 '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<CAP><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- vim.g.python3_host_prog = vim.fn.expand("~/AppData/Local/Programs/Python/Python310/python.exe", false)

-- vim.cmd.syntax='off'
