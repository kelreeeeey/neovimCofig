return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = {
      pane_gap = 4,
      width = 150,
      height = 350,
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
      formats = {
        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ":h")
            local file = vim.fn.fnamemodify(fname, ":t")
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. "/…" .. file
            end
          end
          local dir, file = fname:match("^(.*)/(.+)$")
          return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },
      preset = {
        header = [[
                                                                                                                     
       ██████████    █████████      ██████████ ████████   ███   ███████          ████    ▒ ▓     ▒░  ▓░ ███████████  
        ██     ███  ███     ███      ██        █▒█   ░███ █▓█  ███   ████      ████ ███  ███     ██░ ██     ███      
        ██      ██  ██       ██      ██        █▒█    ███ █▓█ ███             ███     ██ █▒█     ██  ██     █▒█      
        ██      ██  ██       ██      ████████  █▒███████  █▓█ █▒█              ██████    █▒████████  ██     █▒█      
        ██      ██  ██       ██      ██        █▒█        █▓█ ███     ███          ████  █▒█     ██  ██     █▒█      
        ██     ███  ███     ███      ██        █▒█        █▓█  ████  ███▓     ███    ███ █▒█     ██  ██     █▒█      
       ██████████    █████████      ▒█████████ ███        ███    ██████        ████████░ ███    ▒███ ███    ███  ███ 
                                                                                                                     ]]
      },
      sections = {
        { pane=1, section = "header", indent = 2, align = "center"},
        { pane=2, title = "Recent Global Buffers", padding = 1 },
        { pane=2, section = "recent_files", limit = 4, padding = 1, indent=3 },

        { pane=2, title = "Recent Local Buffers", file = vim.fn.fnamemodify("..", ":~"), padding = 1 },
        { pane=2, section = "recent_files", cwd = true, limit = 4, padding = 1, indent=3 },
        { pane=2, title = "~\\obsidian_vaults\\vim_notes", padding = 1, },
        {
          pane=2,
          section = "terminal",
          cmd = "exa -lSR C:\\Users\\Lenovo\\obsidian_vault\\vim_notes ",
          padding = 0,
          limit = 100,
          indent = 3,
          align = "center"
        }

      },
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    },
}
