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
      -- width = 150,
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
                                                                      
                                                                      
                                                                      
                                                                      
                                                                      
                                                                      
  ███                                           
       ██████████    █████████                                        
        ██     ███  ███     ███                                       
        ██      ██  ██       ███                                      
        ██      ██  ██       ███                                      
        ██     ███  ███     ███                                       
       ██████████    █████████                                        
                                                                      
                                                                      
                                                                      
                                                                      
       ██████████ ████████   ███   ███████                            
        ██        █▒█   ░███ █▓█  ███   ████                          
        ██        █▒█    ███ █▓█ ███                                  
        ████████  █▒███████  █▓█ █▒█                                  
        ██        █▒█        █▓█ ███     ███                          
        █████████ █▒█        █▓█  ████  ███▓                          
       ▒█████████ ███        ███    ██████                            
                                                                      
                                                                      
                                                                      
          ████    ▒ ▓     ▒░  ▓░                                      
        ████████  ███     ██░ ██ ███████████                          
       ███    ███ █▒█     ██  ██     █▒█                              
        ███████   █▒████████  ██     █▒█                              
            █████ █▒█     ██  ██     █▒█                              
       ███    ███ █▒█     ██  ██     █▒█                              
        ████████░ ███    ▒███ ███    ███  ███      ]]
      },
      sections = {
        { pane=1, section = "header" },
        { pane=2, title = "Current DIR", padding = 1 },
        {
          pane=2,
          section = "terminal",
          cmd = "lsd",
          padding = 1,
          limit = 15,
          indent = 3,
        },
        { pane=2, title = "MRU", padding = 1 },
        { pane=2, section = "recent_files", limit = 5, padding = 1, indent=3 },
        { pane=2, title = "MRU ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
        { pane=2, section = "recent_files", cwd = true, limit = 8, padding = 1, indent=3 },
        { pane=2, title = "Sessions", padding = 1 },
        { pane=2, section = "projects", padding = 1, indent=3},
        -- { pane=2, title = "Bookmarks", padding = 1 },
        -- { pane=2, section = "keys" },
        { pane=2, footer = {}}
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
