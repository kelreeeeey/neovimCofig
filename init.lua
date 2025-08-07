require("reys.core")
-- require("lazy_bootstrap")
-- require("local_options")

function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC', bold=true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F', bold=true })
end

LineNumberColors()

-- vim.keymap.set('n', '[c', require('treesitter-context').go_to_context, { silent = true })
-- vim.keymap.set('n', "<leader>M", "<CMD>MarkdownPreviewToggle<CR>")
vim.keymap.set('n', "<leader>dt", "<CMD>:put =strftime(' %a %Y-%m-%d %H:%M:%S%z')<CR>")

-- insert mode deletion
-- vim.keymap.set("n", "\\", "<CMD>Oil<CR>", { desc = "Open parent directory in floating window" })
-- vim.keymap.set("n", "|", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
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

-- require("after_lazy")

require("macros")
