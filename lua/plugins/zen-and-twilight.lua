return{
  {
    'folke/twilight.nvim',
    dimming = {
      alpha = 0.85, -- amount of dimming
      -- we try to get the foreground from the highlight groups or fallback color
      color = { "Normal", "#ffffff" },
      term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
      inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
    },
    context = 15, -- amount of lines we will try to show around the current line
    treesitter = true, -- use treesitter when available for the filetype
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
      "function",
      "method",
      "table",
      "if_statement",
    },
    exclude = {}, -- exclude these filetypes
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0., -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 150, -- width of the Zen window
        height = 1, -- height of the Zen window
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = true, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        lualine = { enable = false },
        todo = { enabled = true }, -- if set to "true", todo-comments.nvim highlights will be disabled
        -- this will change the scale factor in Neovide when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
      end,
    }
  }
}
