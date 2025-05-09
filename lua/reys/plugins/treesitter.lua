return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  version = false,
  build = ':TSUpdate',
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  dependencies = {
    -- "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    -- "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        'bash',
        'diff',
        'html',
        'lua',
        'luadoc',
        'odin',
        'markdown',
        'python',
        'query',
        -- 'glslls',
        'regex',
        'elixir',
        'vim',
        'gitignore',
        'bibtex',
        'vimdoc',
        'zig',
        'elixir',
        'c'
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
        disable = { "css", "cls" },
      },

      -- autotag = { enable=false, },

      indent = { enable = true, disable = { 'ruby' } },

      incremental_selection = {

        enable = true,

        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = false,
          node_decremental = "<C-m>"
        }

      },

    })
  end
}
