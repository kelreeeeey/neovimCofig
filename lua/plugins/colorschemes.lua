return {
    -- 'rafi/awesome-vim-colorschemes',
    -- lazy = false,
    -- priority = 1000,
  'Shatur/neovim-ayu',
  mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
  terminal = true, -- Set to `false` to let terminal manage its own colors.
  overrides = function()
    return { Comment = { fg = colors.comment } }
  end
}
