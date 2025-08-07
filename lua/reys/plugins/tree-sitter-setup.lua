return {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile", "FileType", }, --- "VeryLazy" },
    -- lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    -- init = function(plugin)
    --     -- perf: add nvim-treesitter queries to the rtp and it's custom query predicates early
    --     -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    --     -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    --     -- Luckily, the only things that those plugins need are the custom queries, which we make available
    --     -- during startup.
    --     require("lazy.core.loader").add_to_rtp(plugin)
    --     require("nvim-treesitter.query_predicates")
    -- end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "JoosepAlviste/nvim-ts-context-commentstring",
        -- "windwp/nvim-ts-autotag",
        -- "OXY2DEV/markview.nvim",
    },
    keys = {
        { "<c-space>", desc = "Increment Selection" },
        { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    -- opts_extend = { "ensure_installed" },
    -- ---@type TSConfig
    -- ---@diagnostic disable-next-line: missing-fields
    -- opts = ,
    config = function()
        -- if type(opts.ensure_installed) == "table" then
        --   opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
        -- end
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
              "bash",
              "c",
              "html",
              "json",
              "lua",
              "luadoc",
              "markdown",
              "markdown_inline",
              "python",
              "regex",
              "yaml",
              "latex",
              "bibtex",
              "odin",
              "vimdoc",
              "typst",
              "awk",
              "elixir",
              "c",
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

            autotag = { enable=false, },
            indent = { enable = true, disable = { 'ruby' } },

        })
    end,
}
