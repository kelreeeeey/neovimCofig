vim.cmd.colorscheme "ayu"

local function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC', bold=true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F', bold=true })
end

local default_theme = function (theme)
  if theme == "dark" then
    vim.cmd.colorscheme("ayu-light")
  elseif theme == "light" then
    vim.cmd.colorscheme("ayu-dark")
  else
    vim.cmd.colorscheme("ayu-mirage")
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

function ToglleColorscheme()
  default_theme(vim.o.background)
  -- default_theme(vim.g.colors_name)
  LineNumberColors()
end

vim.keymap.set('n', "<A-C>", "<CMD>lua ToglleColorscheme()<CR>")
vim.keymap.set('n', "<A-T>", "<CMD>lua ToglleTransparent()<CR>")
vim.keymap.set('n', '[c', require('treesitter-context').go_to_context, { silent = true })
vim.keymap.set('n', "<leader>M", "<CMD>MarkdownPreviewToggle<CR>")

-- insert mode deletion
vim.keymap.set("n", "\\", "<CMD>Oil<CR>", { desc = "Open parent directory in floating window" })
vim.keymap.set("n", "|", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- NOTE: window resizing
vim.keymap.set("n", "<A-h>", "5<C-w><")
vim.keymap.set("n", "<A-l>", "5<C-w>>")
vim.keymap.set("n", "<A-j>", "5<C-w>-")
vim.keymap.set("n", "<A-k>", "5<C-w>+")

vim.keymap.set("n", "<S-A-h>", "50<C-w><")
vim.keymap.set("n", "<S-A-l>", "50<C-w>>")
vim.keymap.set("n", "<S-A-j>", "50<C-w>-")
vim.keymap.set("n", "<S-A-k>", "50<C-w>+")
LineNumberColors()
