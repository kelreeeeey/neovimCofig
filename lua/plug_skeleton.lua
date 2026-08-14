if vim.loop.os_uname().sysname == "Linux" then
    require("reys.plugins.skeleton").setup({ path = vim.fn.expand("~/.config/nvim/skeletons/") })
else
    require("reys.plugins.skeleton").setup({ path = vim.fn.expand("~/AppData/Local/nvim/skeletons/") })
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    -- Amazing minimal 0 deps plugin for snippets by: Erik
    -- https://blog.erikwastaken.dev/posts/2024-06-14-pluginless-neovim-snippets-in-42-lines-of-lua.html
end
vim.keymap.set('n', '<leader>is', require("reys.plugins.skeleton").show, {})
