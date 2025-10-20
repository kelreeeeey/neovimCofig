local keymap = vim.keymap
vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/kylechui/nvim-surround", version = "v3.1.3" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context", },
    { src = "https://github.com/m4xshen/smartcolumn.nvim", },
})

require("macros")

function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true })
end

LineNumberColors()
--

-- # Oil
require("oil").setup({
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    use_default_keymaps = true,

    columns = { "ctime", "mtime" },

    lsp_file_methods = {
        enabled = true,
        autosave_changes = true
    },

    win_options = {
        wrap = true,
        signcolumn = "no",
        cursorcolumn = false,
        conceallevel = 3,
        concealcursor = "nvic",
        spell = false,
        list = true,
    },

    keymaps = {
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["gx"] = "actions.open_external",
        ["<Esc>"] = "actions.close",
        ["q"] = "actions.close",
    },

    float = {
        padding = 4,
        max_width = 100,
        max_height = 80,
        border = "rounded",
        win_options = {
            winblend = 0
        }
    },

    view_options = {
        show_hidden = false,
        -- is_hidden_file = function(name, _)
        --   local m = name:match("^%.")
        --   return m ~= nil
        -- end,
        is_always_hidden = function(name, _)
            return name == ".." or name == ".git"
        end,
        natural_order = "fast",
        case_insensitive = false,
        sort = {
            { "type", "asc" },
            { "name", "asc" },
        },
        highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
            return nil
        end,
    }
})
keymap.set("n", "|", "<CMD>Oil<CR>", { desc = "Open parent directory in floating window" })
keymap.set("n", "\\", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
--

-- # Telescope

require("telescope").setup({
    defaults = {
        layout_config = {
          vertical = { width = 0.5 }
          -- other layout configuration here
        },
    },
    pickers = {
        find_files = { theme = "dropdown", },
        -- live_grep = { theme = "dropdown", },
        -- grep_string = { theme = "get_cursor" },
        buffers = { theme = "dropdown", },
        tags = { theme = "dropdown", },
    },
})
local builtin = require('telescope.builtin')
local tl_themese = require('telescope.themes')

keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
keymap.set('n', '<leader>fff', builtin.grep_string, { desc = 'Telescope Grep string' })
keymap.set('n', "<leader><leader>", builtin.buffers, { desc = 'Telescope buffers' })
keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
keymap.set('n', '<leader>ft', builtin.tags, { desc = 'Telescope Tags' })
keymap.set('n', '<leader>fq', builtin.quickfix, { desc = 'Telescope Quickfix' })

-- # Surround and autopair
require("nvim-surround").setup({
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    config = function()
        require("nvim-surround").setup({
            keymaps = {
                insert = false,
                insert_line = false,
                normal = false,
                normal_cur = false,
                normal_line = false,
                normal_cur_line = false,
                visual = "<S-s>",
                visual_line = false,
                delete = false,
                change = false,
            },
            aliases = {
                ["a"] = false,
                ["b"] = false,
                ["B"] = false,
                ["r"] = false,
                ["q"] = false,
                ["s"] = false,
            },
        })
    end
})

require("nvim-autopairs").setup({
    event = { "InsertEnter" },
    dependencies = { "hrsh7th/nvim-cmp", },
    config = function()
        -- import nvim-autopairs
        local autopairs = require("nvim-autopairs")

        -- configure autopairs
        autopairs.setup({
            check_ts = true,                        -- enable treesitter
            ts_config = {
                lua = { "string" },                 -- don't add pairs in lua string treesitter nodes
                javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
                -- javascript = { "string", "template_string" },
                java = false,                       -- don't check treesitter on java
            },
            disable_filetype = { "TelescopePrompt", "spectre_panel" },
            disable_in_macro = true,
            disable_in_replace_mode = true,
            enable_moveright = true,
            ignored_next_char = "",
            enable_check_bracket_line = true, --- check bracket in same line
        })

        local Rule = require 'nvim-autopairs.rule'

        local cond = require 'nvim-autopairs.conds'

        autopairs.add_rules({
            Rule("`", "'", "tex"),
            Rule("$", "$", "tex"),
            Rule(' ', ' ')
                :with_pair(function(opts)
                    local pair = opts.line:sub(opts.col, opts.col + 1)
                    return vim.tbl_contains({ '$$', '()', '{}', '[]', '<>' }, pair)
                end)
                :with_move(cond.none())
                :with_cr(cond.none())
                :with_del(function(opts)
                    local col = vim.api.nvim_win_get_cursor(0)[2]
                    local context = opts.line:sub(col - 1, col + 2)
                    return vim.tbl_contains({ '$  $', '(  )', '{  }', '[  ]', '<  >' }, context)
                end),
            Rule("$ ", " ", "tex")
                :with_pair(cond.not_after_regex(" "))
                :with_del(cond.none()),
            Rule("[ ", " ", "tex")
                :with_pair(cond.not_after_regex(" "))
                :with_del(cond.none()),
            Rule("{ ", " ", "tex")
                :with_pair(cond.not_after_regex(" "))
                :with_del(cond.none()),
            Rule("( ", " ", "tex")
                :with_pair(cond.not_after_regex(" "))
                :with_del(cond.none()),
            Rule("< ", " ", "tex")
                :with_pair(cond.not_after_regex(" "))
                :with_del(cond.none()),
        })

        autopairs.get_rule('$'):with_move(function(opts)
            return opts.char == opts.next_char:sub(1, 1)
        end)

        -- import nvim-cmp plugin (completions plugin)
        local cmp = require("cmp")

        -- import nvim-autopairs completion functionality
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        -- make autopairs and completion work together
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done({
                filetypes = {
                    tex = false -- Disable for tex
                }
            })
        )
    end,
})
--

-- # CMP
require("cmp").setup({
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        { "hrsh7th/cmp-buffer",  lazy = true, event = { "InsertEnter", "CmdlineEnter" } }, -- source for text in buffer
        { "hrsh7th/cmp-path",    lazy = true, event = { "InsertEnter", "CmdlineEnter" } }, -- source for file system paths
        { "hrsh7th/cmp-cmdline", lazy = true, event = { "InsertEnter", "CmdlineEnter" } },
        "petertriho/cmp-git",
    },
    config = function()
        local cmp = require("cmp")
        local kind_icons = {
            article = "󰧮",
            book = "",
            incollection = "󱓷",
            Function = "󰊕",
            Constructor = "",
            Text = "󰦨",
            Method = "",
            Field = "󰅪",
            Variable = "󱃮",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "󰚯",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "󰌁",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "󰀫",
            Struct = "",
            Event = "",
            Operator = "󰘧",
            TypeParameter = "",
        }

        cmp.setup({
            completion = {
                completeopt = "menu,noselect",
                keyword_length = 1,
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
                ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),

            -- formatting for autocompletion
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        spell = "[Spell]",
                        buffer = "[Buffer]",
                        cmdline = "[CMD]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end,
            },

            sources = cmp.config.sources({

                { name = "nvim_lsp" },
                { name = "buffer",  keyword_length = 3 },
                {
                    name = "spell",
                    keyword_length = 4,
                    option = {
                        keep_all_entries = false,
                        enable_in_context = function()
                            return true
                        end
                    },
                },

                { name = "path" },
            }),

            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },

            view = { entries = "custom" },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            performance = {
                trigger_debounce_time = 500,
                throttle = 550,
                fetching_timeout = 80,
            },

        })

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" }
            }
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "path" },
                { name = "cmdline" }
            }
        })
    end
})
--

require("smartcolumn").setup({
    disabled_filetypes = { "help", "text" }
})

