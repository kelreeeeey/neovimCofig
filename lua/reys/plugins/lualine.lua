return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "echasnovski/mini.icons" },
    lazy = false,
    priority = 1000,
    config = function()
    require("lualine").setup({
      options = {
        theme = 'ayu',
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          { "fileformat", "filetype" },
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "fugitive", "quickfix", "fzf", "lazy", "mason", "nvim-dap-ui", "oil", "trouble"},
    })
    end,
}
