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

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local set_opt_local = function(tabstop, theme, foldmethod)
            vim.opt_local.tabstop = tabstop -- Number of spaces a tab represents
            vim.opt_local.shiftwidth = tabstop -- Number of spaces for each indentation
            vim.opt_local.expandtab = true -- Convert tabs to spaces
            vim.opt_local.smartindent = true -- Automatically indent new lines
            vim.opt_local.foldmethod = foldmethod
          end

          if vim.bo.filetype == "js" then
            set_opt_local(2, "onedark_dark", "syntax")
          end

          if vim.bo.filetype == "html" then
            set_opt_local(2, "onedark_dark", "syntax")
          end

          if vim.bo.filetype == "json" then
            set_opt_local(2, "onedark_dark", "syntax")
          end

          if ( vim.bo.filetype == "yaml" ) then
            set_opt_local(4, "onelight", "syntax")
          end


          if ( vim.bo.filetype == "latex" ) or ( vim.bo.filetype == "tex" ) or ( vim.bo.filetype == "bib" ) then
            set_opt_local(4, "onelight", "syntax")
          end

          if ( vim.bo.filetype == "markdown" ) or ( vim.bo.filetype == "md" ) then
            set_opt_local(4, "onedark_dark", "syntax")
          end


          if ( vim.bo.filetype == "python" ) or ( vim.bo.filetype == "py" ) then
            set_opt_local(4, "onedark_dark", "syntax")
          end

          if vim.bo.filetype == "lua" then
            set_opt_local(2, "onedark_dark", "syntax")
          end

          if vim.bo.filetype == "c" then
            set_opt_local(4, "onedark_dark", "syntax")
          end

          if vim.bo.filetype == "sh" then
            set_opt_local(4, "onedark_dark", "syntax")
          end

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

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

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
        'zls',
        'black',
        'elixir-ls',
        'awk-language-server',
        'html-lsp',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  }
}
