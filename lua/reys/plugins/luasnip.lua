return {
  "L3MON4D3/LuaSnip",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/" })
    require("luasnip.loaders.from_snipmate").lazy_load() -- Lazy loading
  end
}
