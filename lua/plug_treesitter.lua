vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context", },
})


-- # Tree-sitter
if vim.loop.os_uname().sysname == "Linux" then
    require('treesitter-context').setup {
        enable = true,
        multiline_threshold = 5,
        max_lines = 2,
    }
else
    require("nvim-treesitter").setup()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "bash", "c", "html", "json",
            "lua", "luadoc", "markdown",
            "markdown_inline", "python",
            "yaml", "latex", "bibtex",
            "odin", "vimdoc",
            "awk", "c", "javascript", "html", "json"
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-n>",
                node_incremental = "<C-n>",
                scope_incremental = false,
                node_decremental = "<C-m>"
            },
        },

        textobjects = {
            move = {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
            },
        },

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { 'ruby' },
            disable = { "css", "cls" },
        },

        autotag = { enable = true, },
        indent = { enable = true, disable = { 'ruby' } },

    })
    require('treesitter-context').setup {
        enable = true,
        multiline_threshold = 5,
        max_lines = 2,
    }
end
