local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    { import = "plugins.lspconfig" },
    { import = "plugins.lspconfig-languages" },
    { import = "plugins.snake-nvim" },

    { import = "plugins.lualine" },
    { import = "plugins.colorschemes" },
    "alvan/vim-closetag",
    "kiyoon/magick.nvim",

    { import = "plugins.transparent" },
    { import = "plugins.noice" },
    { import = "plugins.zen-and-twilight" },
    { import = "plugins.vimtex" },
    { import = "plugins.whichpy" },
    { import = "plugins.oil" },
    { import = "plugins.treesitter" },
    { import = "plugins.render-markdown" },
    { import = "plugins.obsidian" },
    { import = "plugins.whichkey" },
    { import = "plugins.telescope"  },
    { import = "plugins.luasnip" },
    { import = "plugins.autocompletion" },
    { import = "plugins.mini"  },
    { import = "plugins.persistence" },
    { import = "plugins.todo-folke" },
    { import = "plugins.harpoon2" },
    { import = "plugins.tree-sitter-context" },
    -- { import = "plugins.tree-sitter-textobjects" },
    { import = "plugins.markdown-preview" },
    { import = "plugins.smartcolumn" },

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


