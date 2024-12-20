require("myconfig.customoptions")
require("legacy.keymaps")
require("legacy.autocommands")

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

vim.o.tabstop = 2 -- Number of spaces a tab represents
vim.o.shiftwidth = 2 -- Number of spaces for each indentation
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.smartindent = true -- Automatically indent new lines
vim.o.foldmethod = "indent"
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
require('lazy').setup({
  { import = "plugins.lspconfig" },
  { import = "plugins.snake-nvim" },
  'marko-cerovac/material.nvim',
  { import = "plugins.colorscheme-oxcarbon" },
  'alvan/vim-closetag',
  'Xuyuanp/nerdtree-git-plugin',
  'tiagofumo/vim-nerdtree-syntax-highlight',
  'folke/twilight.nvim',
  'xiyaowong/nvim-transparent',
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { import = "plugins.noice" },
  { import = "plugins.lualine" },
  -- { import = "plugins.snack-dashboard" },
  { import = "plugins.whichpy" },
  { import = "plugins.oil" },
  { import = "plugins.treesitter" },
  { import = "plugins.null-ls" },
  { import = "plugins.render-markdown" },
  { import = "plugins.obsidian" },
  { import = "plugins.whichkey" },
  { import = "plugins.telescope"  },
  { import = "plugins.luasnip" },
  { import = "plugins.autocompletion" },
  { import = "plugins.mini"  },
  { import = "plugins.persistence" },
  { import = "plugins.todo-folke" },
  -- { import = "plugins.autosession" },
  { import = "plugins.harpoon2" },
  { import = "plugins.tree-sitter-context" },
  { import = "plugins.markdown-preview" },
  { import = 'legacy.lint' },
  { import = 'legacy.autopairs' },
  { import = 'legacy.indent_line' },
  { import = 'legacy.debug' },
  { import = 'legacy.gitsigns' },
  { import = 'legacy.indent_line' },
  { import = 'plugins.obsidian' },
  { import = 'legacy.lint' },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim.opt.background "dark" -- set this to dark or light
vim.cmd.colorscheme "oxocarbon"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- vim.cmd.colorscheme "material-deep-ocean"
vim.keymap.set('n', '[c', require('treesitter-context').go_to_context, { silent = true })
vim.keymap.set('n', '<leader>tp', ':wa!<CR>:! python %<CR>')
-- vim.keymap.set('n', '<leader>tc', ':wa!<CR>:!gcc %<CR>')
-- vim.keymap.set('n', ':Wa1', ':wa!')
-- vim.keymap.set('n', ':Wa!', ':wa!')
-- vim.keymap.set('n', ':WA1', ':wa!')
-- vim.keymap.set('n', ':WA!', ':wa!')
-- vim.keymap.set('n', '<leader>ttp', ':wa!<CR>:split :terminal python %<CR>')

-- insert mode deletion
vim.keymap.set('n', '<C-Bs>', 'db')
vim.keymap.set('n', '<C-Del>', 'de')
vim.keymap.set("n", "\\", "<CMD>Oil --float<CR>", { desc = "Open parent directory in floating window" })
vim.keymap.set("n", "< C-\\ >", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- window resizing
vim.keymap.set("n", "<A-h>", "5<C-w><")
vim.keymap.set("n", "<A-l>", "5<C-w>>")
vim.keymap.set("n", "<A-j>", "5<C-w>-")
vim.keymap.set("n", "<A-k>", "5<C-w>+")

vim.keymap.set("n", "<S-A-h>", "50<C-w><")
vim.keymap.set("n", "<S-A-l>", "50<C-w>>")
vim.keymap.set("n", "<S-A-j>", "50<C-w>-")
vim.keymap.set("n", "<S-A-k>", "50<C-w>+")
vim.keymap.set('n', '<Leader>ii', ':lua vim.cmd("DiagnosticsToggleVirtualText")<CR>')

-- local python_path = 'D:\\APLIKASI\\pythons\\python.exe'
-- vim.keymap.set('n', '<leader>py',  ':WhichPy select ' .. python_path )
-- require('lazy').setup('plugins.obsidian')

