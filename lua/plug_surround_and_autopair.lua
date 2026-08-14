vim.pack.add({
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/kylechui/nvim-surround",                  version = "v3.1.3" },
})


-- # Surround and autopair
require("nvim-surround").setup({})

local autopairs = require("nvim-autopairs")
local Rule = require 'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'
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

autopairs.get_rule('$'):with_move(
  function(opts)
    return opts.char == opts.next_char:sub(1, 1)
  end
)


