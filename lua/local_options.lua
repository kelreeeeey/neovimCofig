
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

-- local map = function(keys, func, desc, mode)
--     mode = mode or 'n'
--     vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
-- end
-- set_lsp_callback_keymaps(map)
-- caps.enable("i")
-- caps.enable("c")
-- caps.enable("n")
