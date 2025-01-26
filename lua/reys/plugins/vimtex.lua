return
{
  'lervag/vimtex',
  lazy = false,     -- we don't want to lazy load VimTeX
  tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    local g = vim.g

    -- disable `K` as it conflicts with LSP hover
    -- from  ( https://inwon.net/blog/vimtex-lazyvim#vimtex )
    -- vim.api.nvim_create_autocmd({ "FileType" }, {
    --   group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
    --   pattern = { "bib", "tex" },
    --   callback = function()
    --     vim.wo.conceallevel = 0
    --   end,
    -- })
    -- Other settings
    g.vimtex_mappings_enabled = false          -- Disable default mappings
    g.tex_flavor = 'latex'                     -- Set file type for TeX files
    g.vimtex_parser_bib_backend = 'bibtex'
    g.tex_indent_brace = false                 -- Disable brace indent
    -- g.vimtex_mappings_disable = { ["n"] = { "K" } } 
    -- g.vimtex_view_skim_sync = 1
    -- g.vimtex_view_skim_activate = 1
    -- g.vimtex_view_skim_reading_bar = 1
    -- g.vimtex_indent_bib_enabled = 1

    g.vimtex_log_ignore = {                    -- Suppress specific log messages
      'Underfull',
      'Overfull',
      'specifier changed to',
      'Token not allowed in a PDF string',
    }
    g.vimtex_compiler_method = 'generic'
    g.vimtex_compiler_generic = {
        command = 'bash build_latex.sh *.tex',
        hooks = {}
      }
    -- g.vimtex_compiler_latexmk_engines = { _ = "-pdflatex", pdflatex="-pdflatex" }
    -- g.vimtex_compiler_latexmk = {
    --     aux_dir = "./aux",
    --     out_dir = "",
    --     callback = 0,
    --     continuous = 0,
    --     executable = 'latexmk',
    --     -- options = {  "-shel-escape", "-synctex=1", "-interaction=nonstopmode" }
    --   }
    g.vimtex_view_general_viewer = "SumatraPDF"
    g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    -- g.vimtex_quickfix_open_on_warning = 0
  end
}
