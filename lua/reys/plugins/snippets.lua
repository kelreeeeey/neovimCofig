return {
    -- { "SirVer/ultisnips" },
    -- { "thomasfaingnaert/vim-lsp-snippets" },
    -- { "thomasfaingnaert/vim-lsp-ultisnips" },
    'dcampos/nvim-snippy',
    config = function()
        require('snippy').setup({
            mappings = {
                is = {
                    ['<Tab>'] = 'expand_or_advance',
                    ['<S-Tab>'] = 'previous',
                },
                nx = {
                    ['<leader>x'] = 'cut_text',
                },
            },
        })
    end,
}
