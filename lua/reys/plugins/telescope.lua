return  { 
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim',
        "nvim-telescope/telescope-bibtex.nvim",
        "debugloop/telescope-undo.nvim",
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'echasnovski/mini.icons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup{
        pickers = {
          help_tags  = {theme="ivy"},
          keymaps  = {theme="dropdown"},
          find_files = {theme="ivy"},
          builtin = {theme="iyv"},
          grep_string = {theme="ivy"},
          diagnostics  = {theme="ivy"},
          live_grep = {theme="ivy"},
          resume = {theme="dropdown"},
          oldfiles = {theme="dropdown"},
          buffers  = {theme="ivy"},
          bibtex  = {theme="ivy"},
        },
        path_display = { "truncate" },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          ['bibtex'] = {
            theme = require('telescope.themes').get_ivy(),
            global_files = {
              "~\\obsidian_vault\\database\\zotero\\zotero_bibtex.bib",
              "~\\Kelreys\\ugthesis-draft\\c0_references\\references.bib",
              "~\\Kelreys\\ugthesis-draft\\c0_references\\zotero.bib",
              "D:\\KELREYS\\undergradproject\\draft\\c0_references\\references.bib",
              "D:\\KELREYS\\undergradproject\\draft\\c0_references\\zotero.bib",
            },
            search_keys = { 'author', 'year', 'title' },
            citation_format = '{{author}} ({{year}}), {{title}}.',
            citation_trim_firstname = true,
            citation_max_auth = 2,
            custom_formats = {
              { id = 'citet', cite_maker = '\\citet{%s}' },
              { id = 'citep', cite_maker = '\\citep{%s}' }
            },
            format = 'citet',
            context = true,
            context_fallback = true,
            wrap = true,
          }
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'bibtex')
      pcall(require('telescope').load_extension, 'yank_history')

      -- See `:help telescope.builtin`
      local builtin = require "telescope.builtin"
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n',
                    '<leader>/',
                    function()
                        builtin.current_buffer_fuzzy_find(
                        require('telescope.themes').get_ivy())
                    end,
                    { desc = '[/] Fuzzily search in current buffer' }
            )

      vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n',
        '<leader>sn',
        function()
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end,
        { desc = '[S]earch [N]eovim files' }
      )
    end,
  },

  { "nvim-telescope/telescope-live-grep-args.nvim" }
}
