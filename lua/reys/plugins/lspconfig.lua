local set_lsp_callback_keymaps = function(map)

    local tele = require 'telescope.builtin'
    map('gd', tele.lsp_definitions, '[G]oto [D]efinition')

    map('gr', tele.lsp_references, '[G]oto [R]eferences')

    map('gI', tele.lsp_implementations, '[G]oto [I]mplementation')

    map('<leader>D', tele.lsp_type_definitions, 'Type [D]efinition')

    map('<leader>ds', tele.lsp_document_symbols, '[D]ocument [S]ymbols')

    map('<leader>ws', tele.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

end

return {
    { -- LSP Plugins
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
    { -- Main LSP config.
        'neovim/nvim-lspconfig',
        event = "BufReadPre",
        lazy = true,
        dependencies = {
            -- NOTE: Must be loaded before dependants
            { 'williamboman/mason.nvim', event = "BufReadPre", config = true },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            -- { 'j-hui/fidget.nvim', lazy=true, event = "BufReadPre", opts = {} },
            'hrsh7th/cmp-nvim-lsp',
            { "antosha417/nvim-lsp-file-operations", config = false,},
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),

                callback = function(event)

                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    set_lsp_callback_keymaps(map)

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

                        -- vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        --     buffer = event.buf,
                        --     group = highlight_augroup,
                        --     callback = vim.lsp.buf.document_highlight,
                        -- })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                            end,
                        })
                      end

                    if client and client.name == 'ruff' then
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end

                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, '[T]oggle Inlay [H]ints')
                    end

                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force',
                                                capabilities,
                                                require('cmp_nvim_lsp').default_capabilities()
            )

            local servers = {
                clangd = {},
                -- rust_analyzer = {},
                pyright = {
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
                ruff = {
                    init_options = {
                        settings = {
                            configuration = "~/AppData/Local/nvim/ruff.toml",
                            configurationPreference = "filesystemFirst",
                            exclude = {"**/tests/**"},
                            lineLength = 85,
                            lint = {
                                enable = true,
                                preview = true
                            },
                        },
                    },
                },
                zls = {},
                codelldb = {},
                ols = {},
                awk_ls = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                            callSnippet = 'Replace',
                        },
                        diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
                markdown_oxide = {},
                -- ltex_plus = {
                --     settings = {
                --         enable = {
                --             "bibtex", "context", "context.tex", "html", "latex", "asciidoc",
                --             "neorg", "org", "quarto", "restructuredtext", "rsweave"
                --         }
                --     }
                -- }
            }

            require('mason').setup()

            local ensure_installed = vim.tbl_keys(servers or {})

  -- Installed
  --   ◍ elixir-ls elixirls
  --   ◍ awk-language-server awk_ls
  --   ◍ bash-language-server bashls
  --   ◍ black
  --   ◍ clangd
  --   ◍ latexindent
  --   ◍ lua-language-server lua_ls
  --   ◍ ols
  --   ◍ pyright
  --   ◍ ruff
  --   ◍ texlab



            vim.list_extend(ensure_installed, {
                -- 'stylua', -- Used to format Lua code
                'ols',
                'clangd',
                -- 'codelldb',
                -- 'zls',
                -- "ltex-ls-plus",
                "latexindent",
                "texlab",
                -- "markdown-oxide",
                'ruff',
                'pyright',
                'black',
                "bashls",

                'elixir-ls',
                -- 'html-lsp',

                -- "yaml-language-server",
                -- 'awk-language-server',
                'lua-language-server',
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            require('mason-lspconfig').setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend(
                                'force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }

        end
    },
}
