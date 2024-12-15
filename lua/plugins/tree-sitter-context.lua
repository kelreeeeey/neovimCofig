return {
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    require('treesitter-context').setup {
      enable = true,
      -- ... other configuration options as you've specified ...
    }
  end,
}
