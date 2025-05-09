return {
    "hrsh7th/nvim-cmp",
    -- commit = pin_commit("2e4270d02843d15510b3549354e238788ca07ca5"),
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        {"hrsh7th/cmp-buffer", lazy=true, event = { "InsertEnter", "CmdlineEnter" }}, -- source for text in buffer
        {"hrsh7th/cmp-path", lazy=true, event = { "InsertEnter", "CmdlineEnter" }}, -- source for file system paths
        -- "L3MON4D3/LuaSnip", -- snippet engine
        -- "saadparwaiz1/cmp_luasnip", -- for autocompletion
        {"hrsh7th/cmp-cmdline", lazy=true, event = { "InsertEnter", "CmdlineEnter" }},
        "petertriho/cmp-git",
        -- "f3fora/cmp-spell",
        -- "micangl/cmp-vimtex",
        {'dcampos/cmp-snippy', lazy=true, event = { "InsertEnter", "CmdlineEnter" }}
    },
    config = function()
        local cmp = require("cmp")
        -- local luasnip = require("luasnip")
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
            -- Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            -- spell = "",
            -- EnumMember = "",
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

          -- configure how nvim-cmp interacts
          -- with snippet engine
          snippet = {
            expand = function(args)
                    require 'snippy'.expand_snippet(args.body)
              -- luasnip.lsp_expand(args.body)
            end,
          },

          mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<CR>"] = cmp.mapping.confirm({ select=false }),
            -- ["<Tab>"] = cmp.mapping(
            --   function(fallback)
            --     if luasnip.expandable() then
            --       luasnip.expand()
            --     elseif luasnip.locally_jumpable(1) then
            --       luasnip.jump(1)
            --     elseif cmp.visible() then
            --       cmp.select_next_item()
            --     else
            --       fallback()
            --     end
            --   end,
            --   { "i", "s" }
            -- ),
            -- ["<S-Tab>"] = cmp.mapping(
            --   function()
            --     if cmp.visible() then
            --       cmp.select_prev_item()
            --     elseif luasnip.locally_jumpable(-1) then
            --       luasnip.jump(-1)
            --     else
            --       -- fallback()
            --     end
            --   end,
            --   { "i", "s" }
            -- ),
          }),

          -- formatting for autocompletion
          formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
              -- kind icons
              vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
              vim_item.menu = ({
                -- vimtex = vim_item.menu,
                nvim_lsp = "[LSP]",
                snippy = "[Snippet]",
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

            -- { name = "luasnip" },
            { name = "snippy" },

            -- { name = "vimtex" },

            { name = "buffer", keyword_length = 3 },

            { name = "spell", keyword_length = 4, option = {
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

        cmp.setup.cmdline("/",
        {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" }
          }
        })

        cmp.setup.cmdline(":",
        {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "path" },
            { name = "cmdline" }
          }
        })

        end
}
