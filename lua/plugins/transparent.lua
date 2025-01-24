return {
  'tribela/transparent.nvim',
  event = 'VimEnter',
  config = function()
    require("transparent").setup({
      auto = true,
      exclude = {
        "LineNr"
      }
    })
  end
}
