return {
    require('lspconfig').pyright.setup {
        settings = {
            pyright = {
            -- Using Ruff's import organizer
                disableOrganizeImports = true,
            },
            python = {
                analysis = {
                    -- Ignore all files for analysis to exclusively use Ruff for linting
                    ignore = { '*' },
                },
            },
        },
    },
    require('lspconfig').ruff.setup {
        init_options = {
            settings = {
                configuration = "~/AppData/Local/nvim/ruff.toml",
                configurationPreference = "filesystemFirst",
                exclude = {"**/tests/**"},
                lineLength = 85,
                lint = {
                    enable = true,
                    preview = true
                }
            }
        }
    },
    require'lspconfig'.ols.setup {
        init_options = {
            checker_args = "-strict-style",
            enable_document_symbols = true,
            enable_inlay_hints = true,
            enable_semantic_tokens = true,
            enable_hover = true,
            enable_format = true,
            -- collections = {
            --     {
            --         name = "shared",
            --         path = vim.fn.expand('$HOME/odin-lib')
            --     }
            -- },
        },
    }
}
