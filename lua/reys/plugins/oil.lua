return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function ()
    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      use_default_keymaps = true,

      columns = {
        "icon", "mtime"
      },

      lsp_file_methods = {
        enabled = true,
        autosave_changes = false
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
        is_hidden_file = function(name, _)
          local m = name:match("^%.")
          return m ~= nil
        end,
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
  end
}
