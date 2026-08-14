require("reys.core")
require("plug_colors_related")
--
vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },  -- shared dep
    { src = "https://github.com/hrsh7th/nvim-cmp" },       -- shared dep
    { src = "https://github.com/folke/which-key.nvim" },   -- whichkey (no cfg)
})

require("plug_ultrafold")
require("plug_formatter_conform")
require("my_macros")
require("plug_oil")
require("plug_telescope")
require("plug_surround_and_autopair")
require("plug_autocompletion_nvim_cmp")
require("plug_treesitter")

if vim.loop.os_uname().sysname == "Windows_NT" then
    -- require("plug_obsidian")
    -- require("plug_mason")
    -- require("plug_lsp")
end
require("plug_smartcolumn")
require("plug_lazygit")
require("plug_telescope")
require("plug_skeleton")
require("plug_tag_picker") -- comes after telescope

require("config_fileconfigs")
