vim.cmd.colorscheme "ayu"

local default_theme = function (style)
  theme = vim.o.background
  if theme == "dark" then
    vim.cmd.colorscheme("ayu-light")
  elseif theme == "light" then
    vim.cmd.colorscheme("ayu-dark")
  else
    vim.cmd.colorscheme("ayu-mirage")
  end
end

function toglle_colorscheme()
  default_theme(vim.g.colors_name)
end

vim.keymap.set('n', "<A-C>", "<CMD>lua toglle_colorscheme()<CR>")
vim.keymap.set('n', "<A-T>", "<CMD>TransparentToggle<CR>")
vim.keymap.set('n', '[c', require('treesitter-context').go_to_context, { silent = true })

-- insert mode deletion
vim.keymap.set("n", "\\", "<CMD>Oil --float<CR>", { desc = "Open parent directory in floating window" })
vim.keymap.set("n", "< C-\\ >", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- NOTE: window resizing
vim.keymap.set("n", "<A-h>", "5<C-w><")
vim.keymap.set("n", "<A-l>", "5<C-w>>")
vim.keymap.set("n", "<A-j>", "5<C-w>-")
vim.keymap.set("n", "<A-k>", "5<C-w>+")

vim.keymap.set("n", "<S-A-h>", "50<C-w><")
vim.keymap.set("n", "<S-A-l>", "50<C-w>>")
vim.keymap.set("n", "<S-A-j>", "50<C-w>-")
vim.keymap.set("n", "<S-A-k>", "50<C-w>+")
