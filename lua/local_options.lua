local foldmethod_guards = function(fold_method)
    vim.api.nvim_create_autocmd({ "FileType" }, {
        callback = function()
            if fold_method == "expr" and require("nvim-treesitter.parsers").has_parser() then
                vim.opt_local.foldmethod = fold_method
                vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
                -- vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            else
                vim.opt_local.foldmethod = fold_method
            end
        end,
    })
end

local set_opt_local = function(fileconfigs)
    if fileconfigs ~= nil then
        vim.opt_local.tabstop = fileconfigs.tabstop -- Number of spaces a tab represents
        vim.opt_local.shiftwidth = fileconfigs.shiftwidth -- Number of spaces for each indentation
        vim.opt_local.expandtab = fileconfigs.expandtab -- Convert tabs to spaces
        vim.opt_local.smartindent = fileconfigs.smartindent -- Automatically indent new lines
        foldmethod_guards(fileconfigs.foldmethod)
    end
end

local set_lsp_callback_keymaps = function(map)

    local tele = require 'telescope.builtin'
    map('gd', tele.lsp_definitions, '[G]oto [D]efinition')

    map('gr', tele.lsp_references, '[G]oto [R]eferences')

    map('gI', tele.lsp_implementations, '[G]oto [I]mplementation')

    map('<leader>D', tele.lsp_type_definitions, 'Type [D]efinition')

    map('<leader>ds', tele.lsp_document_symbols, '[D]ocument [S]ymbols')

    map('<leader>ws', tele.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

end

local filetype_config = {

    md = { tabstop=4, shiftwidth=4, expandtab=false, smartindent=false, foldmethod="manual"},
    markdown = { tabstop=4, shiftwidth=4, expandtab=false, smartindent=false, foldmethod="manual"},
    mkd = { tabstop=4, shiftwidth=4, expandtab=false, smartindent=false, foldmethod="manual"},

    latex = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="syntax"},
    tex = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="syntax"},
    bib = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="syntax"},

    lua = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},

    python = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},
    py = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},

    odin = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},
    sh = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},

    c = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},
    cpp = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},
    h = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},
    zig = { tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="expr"},

    html = {tabstop=2, shiftwidth=2, expandtab=true, smartindent=true, foldmethod="expr"},
    json = { tabstop=2, shiftwidth=2, expandtab=true, smartindent=true, foldmethod="syntax"},
    yaml = { tabstop=2, shiftwidth=2, expandtab=true, smartindent=true, foldmethod="syntax"},

    ex = { tabstop=2, shiftwidth=2, expandtab=true, smartindent=true, foldmethod="expr"},
    exs = { tabstop=2, shiftwidth=2, expandtab=true, smartindent=true, foldmethod="expr"},
    elixir = { tabstop=2, shiftwidth=2, expandtab=true, smartindent=true, foldmethod="expr"},
    js = {tabstop=4, shiftwidth=4, expandtab=true, smartindent=true, foldmethod="syntax"} ,

}

-- local caps = require 'capslock'
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup('FormatBuffer', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        set_lsp_callback_keymaps(map)
        set_opt_local(filetype_config[vim.bo.filetype])
        -- caps.enable("i")
        -- caps.enable("c")
        -- caps.enable("n")
    end,
})
