vim.pack.add({
    -- colorschemes
    { src = "https://github.com/Shatur/neovim-ayu" },
    { src = "https://github.com/norcalli/nvim-colorizer.lua" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = 'https://github.com/nyngwang/nvimgelion', },
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
})
vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } }

-- vim.cmd.colorscheme "zaibatsu"
-- vim.cmd.colorscheme "hemisu"
-- vim.cmd.colorscheme "nvimgelion"
require('ayu').setup({
    mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    terminal = true, -- Set to `false` to let terminal manage its own colors.
    overrides = {
        Normal = { bg = "#000C1A" },
        NormalFloat = { bg = "#000C1A" },
        ColorColumn = { bg = "#000C1A" },
        SignColumn = { bg = "#000C1A" },
        Folded = { bg = "#000C1A" },
        FoldColumn = { bg = "#000C1A" },
        CursorLine = { bg = "#000C1A" },
        CursorColumn = { bg = "#000C1A" },
        VertSplit = { bg = "#000C1A" },
    },
})

-- vim.cmd("colorscheme ayu-dark")
-- vim.cmd("colorscheme tokyonight-night")
vim.cmd("colorscheme catppuccin-nvim")
vim.g.guifont = "IosevkaTerm Nerd Font"
vim.g.ayu_avoid_italics = true
vim.g.termguicolor = false
--

-- require('colorizer').setup({
--     '*',
--     odin = { rgb_fn = true, mode = "background" };
-- })

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C78", blend=10, })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B", blend=10, })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF", blend=10, })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66", blend=10, })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379", blend=10, })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD", blend=10, })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2", blend=10, })
end)

local highlight = { "RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange", "RainbowGreen", "RainbowViolet", "RainbowCyan", }
require("ibl").setup { indent = { highlight = highlight } }

--

-- vim.cmd.highlight.guibg=NONE
local function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'grey', bold = false })
    vim.api.nvim_set_hl(0, 'LineNr',      { fg = 'NONE',  bold = false })
    vim.api.nvim_set_hl(0, 'CursorLine',  { bg = 'NONE', underline=true, sp='red'  })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'grey', bold = false })
end
LineNumberColors()

vim.api.nvim_create_autocmd("ColorScheme", {
    -- group = vim.api.nvim_create_augroup('FormatBuffer', { clear = true }),
    callback = LineNumberColors,
})
