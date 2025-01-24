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
    }
}
