vim.pack.add({
    { src = "https://github.com/kevinhwang91/nvim-ufo" }, -- ultra fold
    { src = "https://github.com/kevinhwang91/promise-async" }
})


require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})

