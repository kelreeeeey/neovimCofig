-- vim.cmd.colorscheme "hemisu"
-- vim.cmd.colorscheme "yugen"
-- vim.cmd.colorscheme "candle-grey-transparent"
-- vim.cmd.colorscheme "256_noir"


local default_theme = function ()
    if vim.cmd.background == "dark" or vim.cmd.colorscheme == "retrobox" then
        vim.cmd.colorscheme("shine")
    elseif vim.cmd.colorscheme == "shine" then
        vim.cmd.colorscheme("ayu-dark")
    else
        vim.cmd.colorscheme("shine")
    end
end

function ToglleTransparentOff()
  vim.cmd.TransparentDisable()
  LineNumberColors()
end
function ToglleTransparent()
  vim.cmd.TransparentToggle()
  LineNumberColors()
end
vim.keymap.set('n', "<A-T>", "<CMD>lua ToglleTransparent()<CR>")

function ToglleColorscheme()
    default_theme()
    -- default_theme(vim.g.colors_name)
    LineNumberColors()
end

local themes = {
    "sheodoxdark",
    "yugen",
    "candle-grey-transparent",
    "hemisu",
    "dmg",
    "ayu-dark"
    -- "ayu-dark",
    -- "retrobox",
}

local current_theme = 1  -- Start with first theme

local function cycle_theme()
    -- Cycle through themes using modulo operation
    current_theme = (current_theme % #themes) + 1
    vim.cmd.colorscheme(themes[current_theme])
    LineNumberColors()
end

-- ToglleTransparentOff()
-- Example usage: bind this to a keymap
vim.keymap.set('n', '<leader>tc', cycle_theme, { desc = 'Cycle themes' })

-- vim.keymap.set('n', "<A-C>", "<CMD>lua ToglleColorscheme()<CR>")
