
local function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC', bold=true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F', bold=true })
end

vim.cmd.colorscheme "hemisu"
-- vim.cmd.colorscheme "yugen"
-- vim.cmd.colorscheme "candle-grey-transparent"
-- vim.cmd.colorscheme "256_noir"

LineNumberColors()

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

-- Example usage: bind this to a keymap
vim.keymap.set('n', '<leader>tc', cycle_theme, { desc = 'Cycle themes' })

-- vim.keymap.set('n', "<A-C>", "<CMD>lua ToglleColorscheme()<CR>")
vim.keymap.set('n', '[c', require('treesitter-context').go_to_context, { silent = true })
vim.keymap.set('n', "<leader>M", "<CMD>MarkdownPreviewToggle<CR>")

-- insert mode deletion
vim.keymap.set("n", "\\", "<CMD>Oil<CR>", { desc = "Open parent directory in floating window" })
vim.keymap.set("n", "|", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
-- vim.keymap.set("n", "<leader><leader>x", "<CMD>luafile %<CR>", { desc = "execute this lua file" })

-- NOTE: window resizing
vim.keymap.set("n", "<A-h>", "5<C-w><")
vim.keymap.set("n", "<A-l>", "5<C-w>>")
vim.keymap.set("n", "<A-j>", "5<C-w>-")
vim.keymap.set("n", "<A-k>", "5<C-w>+")

vim.keymap.set("n", "<S-A-h>", "50<C-w><")
vim.keymap.set("n", "<S-A-l>", "50<C-w>>")
vim.keymap.set("n", "<S-A-j>", "50<C-w>-")
vim.keymap.set("n", "<S-A-k>", "50<C-w>+")
vim.diagnostic.config({
    virtual_lines=true,
    underline=true,
    virtual_text=false,

})
-- ToglleTransparentOff()

