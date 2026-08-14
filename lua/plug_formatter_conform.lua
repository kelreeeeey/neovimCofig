vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" }, -- formatter
})

require("conform").setup({
    notify_on_error = false,
    -- Odinfmt gets its configuration from odinfmt.json. It defaults
    -- writing to stdout but needs to be told to read from stdin.
    formatters = {
        -- odinfmt = {
        --     -- Change where to find the command if it isn't in your path.
        --     command = "odinfmt",
        --     args = { "-stdin" },
        --     stdin = true,
        -- },
    },
    -- and instruct conform to use odinfmt.
    formatters_by_ft = {
        -- odin = { "odinfmt" },
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
