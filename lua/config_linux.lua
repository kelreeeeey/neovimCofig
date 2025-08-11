local keymap = vim.keymap
vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    {
        src = "https://github.com/kylechui/nvim-surround",
        version = "v3.1.3"
    },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context", },
    -- { src = "https://github.com/folke/flash.nvim", },
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

-- # FzfLua

-- require("fzf").setup({ 'fzf-native' })
require("fzf-lua").setup({
    'fzf-native',
    winopts = { preview = { default = "builtin" } },
    help_open_win = function(buf, enter, opts)
        opts.border = 'single'
        opts.row = 0
        opts.col = 0
        return vim.api.nvim_open_win(buf, enter, opts)
    end,
})
local actions = require("fzf-lua").actions
actions = {
    files = {
        true, -- uncomment to inherit all the below in your custom config
        -- Pickers inheriting these actions:
        --   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
        --   tags, btags, args, buffers, tabs, lines, blines
        -- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
        -- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
        -- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
        ["enter"]  = actions.file_edit_or_qf,
        ["ctrl-s"] = actions.file_split,
        ["ctrl-v"] = actions.file_vsplit,
        ["ctrl-t"] = actions.file_tabedit,
        ["alt-q"]  = actions.file_sel_to_qf,
        ["alt-Q"]  = actions.file_sel_to_ll,
        ["alt-i"]  = actions.toggle_ignore,
        ["alt-h"]  = actions.toggle_hidden,
        ["alt-f"]  = actions.toggle_follow,
    },
}
keymap.set("n", "<leader>f", "<CMD>FzfLua<CR>", { desc = "FzfLua" })
keymap.set("n", "<leader>fn", "<CMD>FzfLua files cwd=~/AppData/Local/nvim<CR>", { desc = "FzfLua files in nvim directory" })
keymap.set("n", "<leader>ff", "<CMD>FzfLua files<CR>", { desc = "FzfLua files",  })
keymap.set("n", "<leader>fg", "<CMD>FzfLua grep<CR>", { desc = "FzfLua grep" })
keymap.set("n", "<leader>fgc", "<CMD>FzfLua grep_cword<CR>", { desc = "FzfLua grep_cword" })
-- map.set("n", "<leader>fg<S-C>", "<cMD>FzfLua grep_Cword<CR>", { desc = "FzfLua grep_Cword" })
keymap.set("n", "<leader><leader>", "<CMD>FzfLua buffers<CR>", { desc = "FzfLua buffers" })
--

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

-- # Flash

-- require("flash").setup({
--     event = "VeryLazy",
--     opts = {
--         modes = {
--             search = { enabled = true },
--             char = { jump_labels = true, },
--         },
--     },
--     -- stylua: ignore
--     keys = {
--         { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
--         { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
--         { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
--     },
--
-- })

--

require("smartcolumn").setup({
    disabled_filetypes = { "help", "text" }
})

