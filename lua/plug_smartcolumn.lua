vim.pack.add({
    { src = "https://github.com/m4xshen/smartcolumn.nvim", },
})
require("smartcolumn").setup({ disabled_filetypes = { "help", "text" } })
