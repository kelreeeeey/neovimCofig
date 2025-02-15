return {
  'tribela/transparent.nvim',
  lazy=true,
  -- event = 'VimEnter',
  config = function()
    require("transparent").setup({
      auto = false,
      exclude = {
        "LineNr"
      }
    })
  end
}
