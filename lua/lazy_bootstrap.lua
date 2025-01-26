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
    { import = "reys.plugins.colorschemes" },
    { import = "reys.plugins.transparent" },
    { import = "reys.plugins.lualine" },
    { import = "reys.plugins.snake-nvim" },

    { import = "reys.plugins.lspconfig" },
    { import = "reys.plugins.lspconfig-languages" },
    { import = "reys.plugins.telescope"  },

    { import = "reys.plugins.nvim-cmp" },
    { import = "reys.plugins.treesitter" },
    { import = "reys.plugins.tree-sitter-context" },
    { import = "reys.plugins.vimtex" },

    "alvan/vim-closetag",
    "kiyoon/magick.nvim",

    { import = "reys.plugins.whichpy" },
    { import = "reys.plugins.whichkey" },

    { import = "reys.plugins.obsidian" },
    { import = "reys.plugins.render-markdown" },
    { import = "reys.plugins.markdown-preview" },

    { import = "reys.plugins.luasnip" },
    { import = "reys.plugins.autocompletion" },
    { import = 'reys.plugins.autopairs' },
    -- { import = 'legacy.autopairs' },
    { import = "reys.plugins.surround" },

    { import = "reys.plugins.noice" },
    { import = "reys.plugins.zen-and-twilight" },
    { import = "reys.plugins.oil" },
    { import = "reys.plugins.mini"  },
    { import = "reys.plugins.harpoon2" },

    { import = "reys.plugins.persistence" },
    { import = "reys.plugins.todo-folke" },
    -- { import = "plugins.tree-sitter-textobjects" },
    { import = "reys.plugins.smartcolumn" },

    { import = 'legacy.lint' },
    { import = 'legacy.indent_line' },
    { import = 'legacy.debug' },
    { import = 'legacy.gitsigns' },
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



