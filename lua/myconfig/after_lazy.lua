twilight = require("twilight")
-- vim.cmd.colorscheme "material-darker"
-- vim.cmd.colorscheme "tokyonight-night"
-- vim.cmd.colorscheme "bluloco-dark"
-- vim.cmd.colorscheme "onedark_dark"

local default_theme = function(style)
  if style == "industry" then
    vim.cmd.colorscheme("wildcharm")
  elseif style == "wildcharm" then
    vim.cmd.colorscheme("industry")
  else
    vim.cmd.colorscheme("industry")
  end
end

local tokyo_theme = function(style)
  if style == "tokyonight-night" then
    vim.cmd.colorscheme("tokyonight-day")
  elseif style == "tokyonight-day" then
    vim.cmd.colorscheme("tokyonight-night")
  else
    vim.cmd.colorscheme("tokyonight-night")
  end
end

local bluloco_theme = function(style)
  style = require('bluloco').config.style
  if style == "dark" then
    vim.cmd.colorscheme("bluloco-light")
  elseif style == "light" then
    vim.cmd.colorscheme("bluloco-dark")
  else
    vim.cmd.colorscheme("bluloco-dark")
  end
end

local material_theme = function(style)
  require("material")
  style = vim.g.material_style
  if style == "darker" then
    vim.cmd.colorscheme("material-lighter")
  elseif style == "lighter" then
    vim.cmd.colorscheme("material-darker")
  else
    vim.cmd.colorscheme("material-deep-ocean")
  end
end

local onedark_theme = function(style)
  if theme == "onedark_dark" then
    vim.cmd.colorscheme("onelight")

    vim.cmd.colorscheme("onedark_dark")
  else
    vim.cmd.colorscheme("onedark_dark")
  end
end

function toglle_colorscheme()
  theme = vim.g.colors_name
  if theme == "onedark_dark" then
    onedark_theme(theme)
  elseif theme == "bluloco" then
    bluloco_theme(theme)
  elseif theme == "material" then
    material_theme(theme)
  elseif theme == "tokyonight-night" or theme == "tokyonight-day" then
    tokyo_theme(theme)
  elseif theme == "industry" or "wildcharm" then
    default_theme(theme)
  else
    vim.cmd.colorscheme("industry")
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
