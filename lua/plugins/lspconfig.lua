local foldmethod_guards = function(fold_method)
    vim.api.nvim_create_autocmd({ "FileType" }, {
    callback = function()
      if fold_method == "expr" and require("nvim-treesitter.parsers").has_parser() then
          vim.opt_local.foldmethod = fold_method
          vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
      else
          vim.opt_local.foldmethod = fold_method
      end
    end,
    })
end

function Tprint (tbl)
    for index, data in pairs(tbl) do
        for key, value in pairs(data) do
            print('\t', index, key, value)
        end
    end
end

local set_opt_local = function(fileconfigs)
    vim.opt_local.tabstop = fileconfigs.tabstop -- Number of spaces a tab represents
    vim.opt_local.shiftwidth = fileconfigs.shiftwidth -- Number of spaces for each indentation
    vim.opt_local.expandtab = fileconfigs.expandtab -- Convert tabs to spaces
    vim.opt_local.smartindent = fileconfigs.smartindent -- Automatically indent new lines
    foldmethod_guards(fileconfigs.foldmethod)
end

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
        dependencies = {
            -- NOTE: Must be loaded before dependants
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            'hrsh7th/cmp-nvim-lsp',
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

                    local set_local_options = function(file_type)
                        local filetype_config = {
                            js = {tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="syntax"} ,
                            html = {tabstop=2, shiftwidth=2, expandtab=true, smartindent=true, foldmethod="expr"},
                            json = { tabstop=2, shiftwidth=2, expandtab=true, smartindent=true, foldmethod="syntax"},
                            yaml = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="syntax"},
                            lua = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},
                            tex = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},
                            bib = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="syntax"},
                            python = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},
                            c = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},
                            md = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="syntax"},
                            sh = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"}
                        }

                        local file_config = filetype_config[file_type]

                        set_opt_local(file_config)

                        print('filetype=', file_type, ' set fold_method to: ', file_config.foldmethod)
                        if file_type == 'md' then
                            vim.keymap.set('n', 'gf', function()
                              if require('obsidian').util.cursor_on_markdown_link() then
                                return '<cmd>ObsidianFollowLink<CR>'
                              else
                                return 'gf'
                              end
                            end, { noremap = false, expr = true })
                        end

                    end

                    set_local_options(vim.bo.filetype)

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

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
                rust_analyzer = {},
                pyright = {},
                texlab = {},
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
            }

            require('mason').setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua', -- Used to format Lua code
                'ruff',
                'clangd',
                'pyright',
                'zls',
                'black',
                'elixir-ls',
                'awk-language-server',
                'html-lsp',
                "yaml-language-server",
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
