-- return{
--   "nvim-cmp",
--   optional = true,
--   dependencies = {
--     {
--       "garymjr/nvim-snippets",
--       opts = {
--         friendly_snippets = true,
--       },
--       dependencies = { "rafamadriz/friendly-snippets" },
--     },
--   },
--   opts = function(_, opts)
--     opts.snippet = {
--       expand = function(item)
--         local cmp = require "cmp"
--         return cmp.expand(item.body)
--       end,
--     }
--   end,
-- }

return {
  "hrsh7th/nvim-cmp",
  commit = pin_commit("2e4270d02843d15510b3549354e238788ca07ca5"),
  wants = { "LuaSnip" },
  requires = {
    {
      "L3MON4D3/LuaSnip",
      commit = pin_commit("a54b21aee0423dbdce121c858ad6a88a58ef6e0f"),
      event = "BufReadPre",
      wants = "friendly-snippets",
      config = require("doom.modules.config.doom-luasnip"),
      disable = disabled_snippets,
      requires = {
        "rafamadriz/friendly-snippets",
        "luasnip_snippets.nvim",
      },
    },
    {
      "windwp/nvim-autopairs",
      commit = pin_commit("e6b1870cd2e319f467f99188f99b1c3efc5824d2"),
      config = require("doom.modules.config.doom-autopairs"),
      disable = disabled_autopairs,
      event = "BufReadPre",
    },
  },
  config = require("doom.modules.config.doom-cmp"),
  disable = disabled_lsp,
  event = "InsertEnter",
}
