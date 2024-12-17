return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*",
  -- install jsregexp (optional!).  
  -- build = "make install_jsregexp",
  opts = function(_, opts)
    local ls = require "luasnip"
    -- opts = vim.tbl_deep_extend("force", opts, {
    --   history = true,
    --   delete_check_events = "TextChanged",
    -- })
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local c = ls.choice_node
    local extras = require "luasnip.extras"
    local fmt_raw = require ( "luasnip.extras.fmt" ).fmta
    local fmt = function(placeholder, inputs)
      return fmt_raw(placeholder, inputs)
    end
    local rep = extras.rep


    -- NOTE: LaTeX Snippets
    -- NOTE: General begin-end
    --
    -- local tex_begin_end = [[
    --         \begin{{{}}}
    --             {}
    --         \end{{{}}}
    --         ]]

    -- NOTE: Need 1 input in table format
    -- input 1 = figure label
    local tex_add_figure = [[
      \begin{{ figure }}
          \includegrapchis
          \caption{{ Lorem ipsum }}
          \label{{ fig:<1> }}
      \end{{ figure }}
    ]]

    -- NOTE: Adding the snippet, duh!
    local choices = function(name, input_table)
      _ = input_table
      if name == "add_figure" then
        return s(
            "addfig",
            fmt(tex_add_figure, { i(1, "label") })
        )
      else
        print("Not registered")
      end
    end

    ls.add_snippets("tex", choices("add_figure", _))
    -- ls.add_snippets(
    --   "tex",
    --   {
    --     s(
    --       "figure",
    --       {
    --         t("\\begin{"), i(1), t("}"),
    --         t({"", "\t"}), i(0),
    --         t({"", "\\end{"}), rep(1), t("}")
    --       }
    --     )
    --   }
    -- )


    ls.add_snippets(
      "c",
      {
        s(
          "mai",
          {
            t({ "int main()" }),
            t({ "{" }),
            t({ "", "\t", "return 0;" }),
            t({ "}" }),
          }
        )
      }
    )

    ls.add_snippets(
      "cpp",
      {
        s(
          "mai",
          {
            t({ "int main()" }),
            t({ "{" }),
            t({ "", "\t", "return 0;" }),
            t({ "}" }),
          }
        )
      }
    )


    return opts
  end,
}
