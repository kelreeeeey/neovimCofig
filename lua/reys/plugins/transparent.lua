return {
  'tribela/transparent.nvim',
  lazy=false,
  config = function()
    require("transparent").setup({
      auto = true,
      exclude = {
        "LineNr"
      }
    })
  end
}
