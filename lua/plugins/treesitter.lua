return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  version = false,
  build = ':TSUpdate',
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  opts = {
    ensure_installed = {
      'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'python', 'query', 'regex', 'elixir', 'vim', 'zig', 'elixir', 'c' },
    highlight = { enable = true, additional_vim_regex_highlighting = { 'ruby' } },
    indent = { enable = true, disable = { 'ruby' } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-n>",
        node_incremental = "<C-n>",
        scope_incremental = "<C-s>",
        node_decremental = "<C-m>"
      }
    }
  },
}
