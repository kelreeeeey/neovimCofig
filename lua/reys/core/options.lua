vim.g.mapleader      = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

local opt            = vim.opt
local op             = vim.o
local map            = vim.keymap

opt.foldexpr         = 'v:lua.vim.treesitter.foldexpr()'
opt.foldtext         = ''
opt.foldnestmax      = 4
opt.number           = true
opt.relativenumber   = true
opt.mouse            = 'nv' -- Mouse only in normal and viusual mode
opt.showmode         = false

op.tabstop           = 4    -- Number of spaces a tab represents
op.shiftwidth        = 2    -- Number of spaces for each indentation
op.expandtab         = true -- Convert tabs to spaces
op.smartindent       = true -- Automatically indent new lines
op.smarttab          = true -- Automatically indent new lines

opt.foldmethod       = "expr"
opt.winborder        = "rounded"

op.foldcolumn        = "auto" -- '0' is not bad
op.foldlevel         = 99     -- Using ufo provider need a large value, feel free to decrease the value
op.foldlevelstart    = 99
op.foldenable        = true

vim.schedule(function() opt.clipboard = 'unnamedplus' end)

opt.background = "dark"
opt.breakindent = false -- true
opt.autoindent = true
opt.wrap = true
opt.linebreak = false -- true
-- opt.formatoptions = "tcqjw"
opt.formatoptions = "tcqj"
-- opt.tw = 100
opt.expandtab = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = 'no'

opt.updatetime = 250
opt.timeoutlen = 350

opt.splitright = true
opt.splitbelow = true

opt.list = true
opt.listchars = { tab = '→ ', trail = '|', nbsp = '␣' }

opt.inccommand = 'split'
opt.conceallevel = 1
opt.cursorline = true

opt.scrolloff = 10
opt.spelllang = { 'en,idn' }

op.termguicolors = true
vim.cmd ' let g:netrw_liststyle = 4 '


map.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
map.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map.set('t', '<CAP><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

map.set('n', "<leader>v", "<CMD>:vsp<CR>")
map.set('n', "<leader>s", "<CMD>:sp<CR>")
map.set('n', "<leader>dt", "<CMD>:put=strftime('%a %Y-%m-%d %H:%M:%S%z')<CR>")

-- moving around windows
map.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: window resizing
map.set("n", "<A-h>", "5<C-w><")
map.set("n", "<A-l>", "5<C-w>>")
map.set("n", "<A-j>", "5<C-w>-")
map.set("n", "<A-k>", "5<C-w>+")
map.set("n", "<S-A-h>", "50<C-w><")
map.set("n", "<S-A-l>", "50<C-w>>")
map.set("n", "<S-A-j>", "50<C-w>-")
map.set("n", "<S-A-k>", "50<C-w>+")

vim.diagnostic.config({
    virtual_lines=true,
    underline=true,
    virtual_text=false,
})


-- local shell = 'bash'


local set_shell_bash = function()
    vim.o.shell = [["C:/Program Files/Git/usr/bin/bash.exe"]]
    vim.o.shellcmdflag = "-c"
    vim.o.shellredir = ">%s 2>&1"
    vim.o.shellquote = ""
    vim.o.shellxescape = ""
    vim.o.shellslash = true
    vim.env.TMP = "/tmp"
    vim.o.shellxquote = ""
    -- vim.o.shellxquote = "\\"
    vim.o.shellpipe = "2>&1| tee"
end

set_shell_bash()

local mappings = {
    { 'n', '<c-c>', '"+y' },
    { 'v', '<c-c>', '"+y' },
    { 'n', '<c-v>', '"+p' },
    { 'i', '<c-v>', '<c-r>+' },
    { 'c', '<c-v>', '<c-r>+' },
    { 'i', '<c-r>', '<c-v>' },
    { "n", "<c-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.05<CR>", },
    { "n", "<c-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.05<CR>", },
}

if vim.g.neovide == true then
    for _, map in ipairs(mappings) do
        vim.keymap.set(map[1], map[2], map[3])
    end
    vim.g.neovide_scale_factor = 0.725
    vim.api.nvim_set_keymap("n", "<C-1>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
    vim.g.guifont = "IosevkaTerm Nerd Font Mono:h8"
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_cursor_animation_length = 0.06
    vim.g.neovide_cursor_vfx_mode = "ripple"
    -- vim.g.neovide_cursor_vfx_mode = "sonicboom"
    set_shell_bash()
    -- system clipboard
    vim.o.clipboard='unnamedplus'
end

-- vim.g.python3_host_prog = vim.fn.expand("~/AppData/Local/Programs/Python/Python310/python.exe", false)
-- vim.cmd.syntax='off'
-- opt.shell = shell

-- map.set('n', '[c', require('treesitter-context').go_to_context, { silent = true })
-- map.set('n', "<leader>M", "<CMD>MarkdownPreviewToggle<CR>")
--

map.set("n", "<leader><leader>x", "<CMD>luafile %<CR>", { desc = "execute this lua file" })
