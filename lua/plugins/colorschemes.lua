return {
  'Shatur/neovim-ayu',
  mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
  terminal = false, -- Set to `false` to let terminal manage its own colors.
  overrides = function()
    return { Comment = { fg = colors.comment } }
  end
}
