return {
    {
        'andreasvc/vim-256noir',
        -- 'jaredgorski/fogbell.vim',
    },
    {
        'aditya-azad/candle-grey'
    },
    {
        "mstcl/dmg",
        lazy = false,
        priority = 1000,
        -- config = function()
        --     vim.api.nvim_command("colorscheme lush")
        -- end,
    },
    {
        "bettervim/yugen.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "ayu-theme/ayu-vim",
        lazy = false,
        priority = 1000,
    }
    -- {
    --     'Shatur/neovim-ayu',
    --     mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    --     terminal = false, -- Set to `false` to let terminal manage its own colors.
    --     overrides = function()
    --         return { Comment = { fg = colors.comment } }
    --     end
    -- },
}

