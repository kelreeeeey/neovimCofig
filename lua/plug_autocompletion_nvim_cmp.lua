-- # CMP
vim.pack.add({
    { src = "https://github.com/hrsh7th/nvim-cmp" },
})

-- import nvim-cmp plugin (completions plugin)
local cmp = require("cmp")
-- import nvim-autopairs completion functionality
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- make autopairs and completion work together
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({
        filetypes = { tex = false }
    })
)
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
