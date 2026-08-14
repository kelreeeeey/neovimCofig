vim.lsp.enable({ "lua_ls", })
vim.lsp.config(
    "lua_ls",
    {
        settings = {
            Lua = {
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true)
                }
            }
        }
    }
)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "LSP format Lua" })
