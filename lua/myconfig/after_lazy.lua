-- vim.cmd.colorscheme "material-deep-ocean"
-- vim.cmd.colorscheme "bluloco-dark"
vim.cmd.colorscheme "onedark_dark"

function toglle_colorscheme()
  theme = vim.g.colors_name
  if theme == "onedark_dark" then
    vim.cmd.colorscheme("onelight")
  elseif theme == "onelight" then
    vim.cmd.colorscheme("onedark_dark")
  elseif theme == "bluloco" then
    style = require('bluloco').config.style
    if style == "dark" then
      vim.cmd.colorscheme("bluloco-light")
    elseif style == "light" then
      vim.cmd.colorscheme("bluloco-dark")
    else
      vim.cmd.colorscheme("bluloco-dark")
    end
  else
    vim.cmd.colorscheme("onedark_dark")
  end
end

vim.keymap.set('n', "<A-C>", "<CMD>lua toglle_colorscheme()<CR>")
vim.keymap.set('n', "<A-T>", "<CMD>TransparentToggle<CR>")
vim.keymap.set('n', '[c', require('treesitter-context').go_to_context, { silent = true })

-- insert mode deletion
vim.keymap.set("n", "\\", "<CMD>Oil --float<CR>", { desc = "Open parent directory in floating window" })
vim.keymap.set("n", "< C-\\ >", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- window resizing
vim.keymap.set("n", "<A-h>", "5<C-w><")
vim.keymap.set("n", "<A-l>", "5<C-w>>")
vim.keymap.set("n", "<A-j>", "5<C-w>-")
vim.keymap.set("n", "<A-k>", "5<C-w>+")

vim.keymap.set("n", "<S-A-h>", "50<C-w><")
vim.keymap.set("n", "<S-A-l>", "50<C-w>>")
vim.keymap.set("n", "<S-A-j>", "50<C-w>-")
vim.keymap.set("n", "<S-A-k>", "50<C-w>+")
vim.keymap.set('n', '<Leader>ii', ':lua vim.cmd("DiagnosticsToggleVirtualText")<CR>')
