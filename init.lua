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
  { import = "plugins.colorschemes" },
  'alvan/vim-closetag',
  'Xuyuanp/nerdtree-git-plugin',
  'tiagofumo/vim-nerdtree-syntax-highlight',
  'folke/twilight.nvim',
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { import = "plugins.transparent" },
  { import = "plugins.noice" },
  { import = "plugins.lualine" },
  { import = "plugins.vimtex" },
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

-- vim.cmd.colorscheme "oxocarbon"
-- vim.cmd.colorscheme "material-deep-ocean"
vim.cmd.colorscheme "bluloco-dark"

function toglle_colorscheme()
  theme = vim.g.colors_name
  if theme == "onedark_dark" then
    vim.cmd.colorscheme("onelight")
  elseif theme == "onelight" then
    vim.cmd.colorscheme("onedark_dark")
  elseif theme == "bluloco" then
    style = require('bluloco').config.style
    if style == "dark" then
      vim.cmd.colorscheme("bluloco-light")
    elseif style == "light" then
      vim.cmd.colorscheme("bluloco-dark")
    else
      vim.cmd.colorscheme("bluloco-dark")
    end
  else
    vim.cmd.colorscheme("onedark_dark")
  end
end

vim.keymap.set('n', "<A-C>", "<CMD>lua toglle_colorscheme()<CR>")
vim.keymap.set('n', "<A-T>", "<CMD>TransparentToggle<CR>")
vim.keymap.set('n', '[c', require('treesitter-context').go_to_context, { silent = true })

-- insert mode deletion
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

