return { -- Makrdown Preview
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_theme = "light"
    vim.g.mkdp_page_title = '${name}'
    vim.g.mkdp_combine_preview = 1
    vim.g.mkdp_combine_preview = 1
    vim.g.mkdp_auto_close = 0
  end,
  ft = { "markdown" },
}
