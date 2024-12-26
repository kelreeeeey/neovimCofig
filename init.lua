require("myconfig.before_lazy")
require("myconfig.the_lazy")
require("legacy.autocommands")
require('lazy').setup({
  { import = "plugins.lspconfig" },
  { import = "plugins.snake-nvim" },
  { import = "plugins.lualine" },
  { import = "plugins.colorschemes" },
  'alvan/vim-closetag',
  -- 'Xuyuanp/nerdtree-git-plugin',
  -- 'tiagofumo/vim-nerdtree-syntax-highlight',

  { import = "plugins.transparent" },
  { import = "plugins.noice" },
  { import = "plugins.zen-and-twilight" },
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
vim.cmd.colorscheme "ayu"
require("myconfig.after_lazy")
