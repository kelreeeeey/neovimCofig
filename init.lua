require("reys.core")


local keymap = vim.keymap
keymap.set("n", "<leader><leader>x", "<CMD>luafile %<CR>", { desc = "execute this lua file" })

-- require("lazy_bootstrap")

--
vim.pack.add({ { src = "https://github.com/ayu-theme/ayu-vim" }, })
vim.cmd.colorscheme "ayu"
--

--
vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    {
        src = "https://github.com/kylechui/nvim-surround",
        version = "v3.1.3"
    },
    { src = "https://github.com/epwalsh/obsidian.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/neovim/nvim-lspconfig", },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context", },
    { src = "https://github.com/folke/flash.nvim", },
    { src = "https://github.com/mason-org/mason.nvim", },
    { src = "https://github.com/m4xshen/smartcolumn.nvim", },
    { src = "https://github.com/kdheepak/lazygit.nvim", },
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
require("fzf-lua").setup({ 'fzf-native' })
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
keymap.set("n", "<leader>fn", "<CMD>FzfLua files cwd=~/AppData/Local/nvim<CR>",
    { desc = "FzfLua files in nvim directory" })
keymap.set("n", "<leader>ff", "<CMD>FzfLua files<CR>", { desc = "FzfLua files" })
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

-- # OBSIDIAN
-- both exists() and isdir we're coming from stack overflow https://stackoverflow.com/a/40195356/28689941
local function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end
local function isdir(path)
    return exists(path .. "/")
end
local function workspace_path()
    if isdir("C:\\Users\\Lenovo\\obsidian_vault") then
        print("You're in your home")
        return {
            {
                name = 'Kelrey\'s',
                path = "~/obsidian_vault",
                overrides = {
                    templates = {
                        folder = "~/obsidian_vault/bins/templates",
                        date_format = '%Y-%b-%d',
                        time_format = '%H:%M:%m',
                    },
                }
            },
        }
    else
        print("You're in Geosiesmal's house")
        return {
            {
                name = 'Kelreys on Lediapad',
                path = "~/obsidian_vaults",
                overrides = {
                    templates = {
                        folder = "~/obsidian_vaults/bins/templates",
                        date_format = '%Y-%b-%d',
                        time_format = '%H:%M:%m',
                    },
                    notes_subdir = "./",
                }
            },
            {
                name = 'yap on public',
                path = "~/obsidian_public",
                overrides = {
                    templates = {
                        folder = "~/obsidian_public/bins/templates/neovim",
                        date_format = '%Y-%b-%d',
                        time_format = '%H:%M:%m',
                    },
                    notes_subdir = "content",
                }
            }
        }
    end
end
require("obsidian").setup({
    lazy = true,
    ft = 'markdown',
    dependencies = { 'nvim-lua/plenary.nvim', },
    workspaces = workspace_path(),

    daily_notes = {
        folder = 'log/daily',
    },

    completion = {
        nvim_cmp = true,
        min_chars = 2,
    },

    preferred_link_style = 'markdown',
    markdown_link_func = function(opts)
        return require('obsidian.util').markdown_link(opts)
    end,
    sort_by = 'modified',
    sort_reversed = true,
    search_max_lines = 250,
    picker = {
        name = 'fzf-lua',
        note_mappings = {
            new = '<C-x>',
            insert_link = '<C-l>',
        },
        tag_mappings = {
            tag_note = '<C-x>',
            insert_tag = '<C-l>',
        },
    },

    ---@param url string
    follow_url_func = function(url)
        vim.ui.open(url) -- need Neovim 0.10.0+
    end,

    ---@param img string
    follow_img_func = function(img)
        vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
    end,

    use_advanced_uri = true,
    open_app_foreground = false,
    open_notes_in = 'vsplit',
    ui = { enable = false, },

    ---@return table
    note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
            note:add_alias(note.title)
        end

        local out = {
            id = note.id,
            aliases = note.aliases,
            tags = note.tags,
            created = note.created
        }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
                out[k] = v
            end
        end

        return out
    end,
})
keymap.set("n", "<leader>os", "<CMD>ObsidianSearch<CR>", { desc = "ObsidianSearch" })
keymap.set("n", "<leader>ot", "<CMD>ObsidianTemplate<CR>", { desc = "ObsidianTemplate" })
--

-- # Tree-sitter
require("nvim-treesitter").setup()
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash", "c", "html", "json",
        "lua", "luadoc", "markdown",
        "markdown_inline", "python",
        "yaml", "latex", "bibtex",
        "odin", "vimdoc", "typst",
        "awk", "elixir", "c",
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-n>",
            node_incremental = "<C-n>",
            scope_incremental = false,
            node_decremental = "<C-m>"
        },
    },

    textobjects = {
        move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
    },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
        disable = { "css", "cls" },
    },

    autotag = { enable = true, },
    indent = { enable = true, disable = { 'ruby' } },

})

require('treesitter-context').setup {
    enable = true,
    multiline_threshold = 5,
    max_lines = 2,
}
require("mason").setup()
--

-- # LSP(?)
vim.lsp.enable({ "lua_ls", "ruff", "python", "basedpyright" })

vim.lsp.config("lua_ls", { settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true) } } } })
vim.lsp.config("python", {})
vim.lsp.config("ruff", {})
vim.lsp.config("mypy", {})
vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                diagnosticMode = "openFilesOnly",
                inlayHints = {
                    callArgumentNames = true
                }
            }
        }
    }
})

keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "LSP format Lua" })
--

-- # Flash
require("flash").setup({
    event = "VeryLazy",
    opts = {
        modes = {
            search = { enabled = true },
            char = { jump_labels = true, },
        },
    },
    -- stylua: ignore
    keys = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },

})
--

require("smartcolumn").setup({
    disabled_filetypes = { "help", "text" }
})

require("lazygit")
keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>", { desc = "LazyGit" })
keymap.set("n", "<leader>ggc", "<CMD>LazyGitCurrentFile<CR>", { desc = "LazyGitCurrentFile" })
keymap.set("n", "<leader>ggf", "<CMD>LazyGitFilter<CR>", { desc = "LazyGitFilter" })

-- # fff.nvim
-- require("fff").setup({
-- })


-- Amazing minimal 0 deps plugins for snippets by: Erik's Blog
-- https://blog.erikwastaken.dev/posts/2024-06-14-pluginless-neovim-snippets-in-42-lines-of-lua.html
require("reys.plugins.skeleton").setup({ path = vim.fn.expand("~/AppData/Local/nvim/skeletons/") })
vim.keymap.set('n', '<leader>is', require("reys.plugins.skeleton").show, {})

local foldmethod_guards = function(fold_method)
    vim.api.nvim_create_autocmd({ "FileType" }, {
        callback = function()
            if fold_method == "expr" and require("nvim-treesitter.parsers").has_parser() then
                vim.opt_local.foldmethod = fold_method
                vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
                -- vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            else
                vim.opt_local.foldmethod = fold_method
            end
        end,
    })
end

local set_opt_local = function(fileconfigs)
    if fileconfigs ~= nil then
        vim.opt_local.tabstop = fileconfigs.tabstop         -- Number of spaces a tab represents
        vim.opt_local.shiftwidth = fileconfigs.shiftwidth   -- Number of spaces for each indentation
        vim.opt_local.expandtab = fileconfigs.expandtab     -- Convert tabs to spaces
        vim.opt_local.smartindent = fileconfigs.smartindent -- Automatically indent new lines
        foldmethod_guards(fileconfigs.foldmethod)
    end
end

local filetype_config = {
    md = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = false,
        smartindent = false,
        foldmethod = "manual",
    },
    markdown = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "manual",
    },
    mkd = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = false,
        smartindent = false,
        foldmethod = "manual",
    },
    latex = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "syntax",
    },
    tex = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "syntax",
    },
    bib = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "syntax",
    },
    lua = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    python = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    py = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    odin = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    sh = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    c = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    cpp = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    h = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    zig = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    html = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    yaml = {
        tabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        smartindent = true,
        foldmethod = "syntax",
    },
    ex = {
        tabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    exs = {
        tabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    elixir = {
        tabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    js = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "syntax",
    },
    json = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = false,
        foldmethod = "expr",
    },
}

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup('FormatBuffer', { clear = true }),
    callback = function(event)
        set_opt_local(filetype_config[vim.bo.filetype])
    end,
})

-- require("local_options")
