-- source: https://github.com/benbrastmckie/.config/blob/d0ab9efed832aa379ebed6e1d8b6e20225b83331/nvim/lua/neotex/plugins/which-key.lua
return {
    "folke/which-key.nvim",
    -- event = "VeryLazy",
    event = "VimEnter",
    dependencies = { 'echasnovski/mini.nvim',},
    opts = {
        setup = {
            show_help = false,
            -- show the currently pressed key and its label as a message in the command line
            show_keys = false,
            notify = false,           -- prevent which-key from automatically setting up fields for defined mappings
            triggers = {
                { "<leader>", mode = { "n", "v" } },
            },
            plugins = {
                presets = {
                    marks = false,        -- shows a list of your marks on ' and `
                    registers = false,    -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                    spelling = {
                        enabled = false,    -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                        suggestions = 10,   -- how many suggestions should be shown in the list?
                    },
                    operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
                    motions = false,      -- adds help for motions
                    text_objects = false, -- help for text objects triggered after entering an operator
                    windows = false,      -- default bindings on <c-w>
                    nav = false,          -- misc bindings to work with windows
                    z = true,            -- bindings for folds, spelling and others prefixed with z
                    g = false,            -- bindings for prefixed with g
                },
            },
            win = {
                no_overlap = true,
                -- width = 1,
                -- height = { min = 4, max = 25 },
                -- col = 0,
                -- row = math.huge,
                border = "rounded", -- can be 'none', 'single', 'double', 'shadow', etc.
                padding = { 1, 1 }, -- extra window padding [top/bottom, right/left]
                title = false,
                title_pos = "center",
                zindex = 1000,
                -- Additional vim.wo and vim.bo options
                bo = {},
                wo = {
                    winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
                },
            },
            -- add operators that will trigger motion and text object completion
            -- to enable native operators, set the preset / operators plugin above
            -- operators = { gc = "Comments" },
            icons = {
                breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                separator = "➜", -- symbol used between a key and it's label
                group = "+",      -- symbol prepended to a group
            },
            layout = {
                width = { min = 20, max = 50 },                                             -- min and max width of the columns
                height = { min = 4, max = 25 },                                             -- min and max height of the columns
                spacing = 3,                                                                -- spacing between columns
                align = "left",                                                             -- align columns left, center or right
            },
            keys = {
                scroll_down = "<c-d>", -- binding to scroll down inside the popup
                scroll_up = "<c-u>",   -- binding to scroll up inside the popup
            },
            sort = { "local", "order", "group", "alphanum", "mod" },
            -- disable the WhichKey popup for certain buf types and file types.
            -- Disabled by default for Telescope
            disable = {
            bt = { "help", "quickfix", "terminal", "prompt" }, -- for example
            ft = { "Oil" } -- add your explorer's filetype here
            }
        },
        defaults = {
            buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true,  -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true,  -- use `nowait` when creating keymaps
            prefix = "<leader>",
            mode = { "n", "v" },
            b = { "<cmd>VimtexCompile<CR>", "build" },
            v = { "<cmd>vert sb<CR>", "create split" },
            d = { "<cmd>update! | lua Snacks.bufdelete()<CR>", "delete buffer" },
            -- d = { "<cmd>update! | bdelete!<CR>", "delete buffer" },
            e = { "<cmd>Oil<CR>", "explorer" },
            j = { "<cmd>clo<CR>", "drop split" },
            i = { "<cmd>VimtexTocOpen<CR>", "index" },
            k = { "<cmd>on<CR>", "max split" },
            q = { "<cmd>wa! | qa!<CR>", "quit" },
            w = { "<cmd>wa!<CR>", "write" },
            x = { "<cmd>luafile %<CR>", "execute this lua file" },
            p = { "<cmd>lua require('present').start_presentation{}<CR>", "Present Markdown in NVIM" },
            f = {
                name = "FIND",
                c = { "<cmd>Telescope bibtex format_string=\\citet{%s} theme=ivy<CR>", "citations" },
                f = { "<cmd>Telescope live_grep theme=ivy<CR>", "project" },
                l = { "<cmd>Telescope resume<CR>", "last search" },
                q = { "<cmd>Telescope quickfix<CR>", "quickfix" },
                -- h = { "<cmd>Telescope help_tags<CR>", "help" },
                -- k = { "<cmd>Telescope keymaps<CR>", "keymaps" },
                r = { "<cmd>Telescope registers theme=dropdown<CR>", "registers" },
                t = { "<cmd>Telescope colorscheme<CR>", "theme" },
                -- s = { "<cmd>Telescope grep_string<CR>", "string" },
                -- w = { "<cmd>lua SearchWordUnderCursor()<CR>", "word" },
                -- y = { "<cmd>YankyRingHistory<CR>", "yanks" },
                -- m = { "<cmd>Telescope man_pages<CR>", "man pages" },
                -- c = { "<cmd>Telescope commands<CR>", "commands" },
                -- r = { "<cmd>Telescope oldfiles<CR>", "recent" },
            },
            g = {
                name = "GIT",
                c = { "<cmd>Telescope git_commits<CR>", "git commit history" },
                -- g = { "<cmd>lua Snacks.lazygit()<cr>", "lazygit" },
                k = { "<cmd>Gitsigns prev_hunk<CR>", "prev hunk" },
                j = { "<cmd>Gitsigns next_hunk<CR>", "next hunk" },
                s = { "<cmd>Telescope git_status<CR>", "git status" },
                t = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "toggle blame" },
                g = { "<cmd>LazyGit<cr>", "LazyGit" }
            },
            h = {
                name = "Hardtime",
                t = { "<cmd>Hardtime toggle<cr>", "Toggle Hardtime" },
                r = { "<cmd>Hardtime report<cr>", "Report Hardtime" }
            },
            H = {
                name = "HARPOON",
                A = { "<cmd>lua require('harpoon'):list():add()<cr>", "mark" },
                a = { "<cmd>lua require('harpoon.ui'):toggle_quick_menu(require('harpoon'):list())<cr>", "harpoon list" },
                n = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "next" },
                p = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "previous" },
                h1 = { "<cmd>lua require('harpoon'):list():select(1)<cr>", "harpoon to file 1" },
                h2 = { "<cmd>lua require('harpoon'):list():select(2)<cr>", "harpoon to file 2" },
                h3 = { "<cmd>lua require('harpoon'):list():select(3)<cr>", "harpoon to file 3" },
                h4 = { "<cmd>lua require('harpoon'):list():select(4)<cr>", "harpoon to file 4" },
                h5 = { "<cmd>lua require('harpoon'):list():select(5)<cr>", "harpoon to file 5" },
                h6 = { "<cmd>lua require('harpoon'):list():select(6)<cr>", "harpoon to file 6" },
                h7 = { "<cmd>lua require('harpoon'):list():select(7)<cr>", "harpoon to file 7" },
            },
            -- LIST MAPPINGS
            -- L = {
            --   name = "LIST",
            --   c = { "<cmd>lua HandleCheckbox()<CR>", "checkbox" },
            --   -- c = { "<cmd>lua require('autolist').invert()<CR>", "checkbox" },
            --   -- x = { "<cmd>lua handle_checkbox()<CR>", "checkbox" },
            --   -- c = { "<cmd>AutolistToggleCheckbox<CR>", "checkmark" },
            --   n = { "<cmd>AutolistCycleNext<CR>", "next" },
            --   p = { "<cmd>AutolistCyclePrev<CR>", "previous" },
            --   r = { "<cmd>AutolistRecalculate<CR>", "reorder" },
            -- },
            l = {
                name = "LSP",
                b = { "<cmd>Telescope diagnostics bufnr=0<CR>", "buffer diagnostics" },
                c = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "code action" },
                d = { "<cmd>Telescope lsp_definitions<CR>", "definition" },
                D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "declaration" },
                h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "help" },
                i = { "<cmd>Telescope lsp_implementations<CR>", "implementations" },
                k = { "<cmd>LspStop<CR>", "kill lsp" },
                l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "line diagnostics" },
                n = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "next diagnostic" },
                p = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "previous diagnostic" },
                r = { "<cmd>Telescope lsp_references<CR>", "references" },
                s = { "<cmd>LspRestart<CR>", "restart lsp" },
                t = { "<cmd>LspStart<CR>", "start lsp" },
                R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
            },
            r = {
                name = "RUN",
                l = { "vim.diagnostics.setloclist", "locate errors" },
                n = { "function() vim.diagnostic.goto_next{popup_opts = {show_header = false}} end", "next" },
                p = { "function() vim.diagnostic.goto_prev{popup_opts = {show_header = false}} end", "prev" },
                r = { "<cmd>ReloadConfig<cr>", "Reload Configs" },
                h = { "<cmd>Hardtime toggle<cr>", "Hardtime Toggle" },
                s = { "<cmd>lua Snacks.notifier.show_history()<cr>", "Show Notifications" },
            },
            s = {
                name = "SURROUND",
                s = { "<Plug>(nvim-surround-normal)", "surround" },
                d = { "<Plug>(nvim-surround-delete)", "delete" },
                c = { "<Plug>(nvim-surround-change)", "change" },
            },
            o = {
                name = "Obsidian",
                n = { "<cmd>ObsidianNewFromTemplate<CR>", "New Note From Template" },
                N = { "<cmd>ObsidianNew<CR>", "New Note" },
                s = { "<cmd>ObsidianSearch<CR>", "Search Note" },
                w = { "<cmd>ObsidianWorkspace<CR>", "Workspace" },
                t = { "<cmd>ObsidianTemplate<CR>", "Template" },
            },
        },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts.setup)
        wk.register(opts.defaults)
    end,
}
