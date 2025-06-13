return {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
        require('treesitter-context').setup {
            enable = true,
            multiline_threshold = 5,
            max_lines = 2,
        }
    end,
}
