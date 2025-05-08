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
    },

    require'lspconfig'.lua_ls.setup {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend(
            'force',
            client.config.settings.Lua,
            {
                runtime = {
                  -- Tell the language server which version of Lua you're using
                  -- (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT'
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                  }
                  -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                  -- library = vim.api.nvim_get_runtime_file("", true)
                }
            }
        )
    end,
    settings = { Lua = {} }
    }
}
