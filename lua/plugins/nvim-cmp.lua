return{
  "nvim-cmp",
  optional = true,
  dependencies = {
    {
      "garymjr/nvim-snippets",
      opts = {
        friendly_snippets = true,
      },
      dependencies = { "rafamadriz/friendly-snippets" },
    },
  },
  opts = function(_, opts)
    opts.snippet = {
      expand = function(item)
        local cmp = require "cmp"
        return cmp.expand(item.body)
      end,
    }
  end,
}
