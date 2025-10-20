require("reys.core")

local keymap = vim.keymap
keymap.set("n", "<leader><leader>x", "<CMD>luafile %<CR>", { desc = "execute this lua file" })

--
vim.pack.add({
    -- { src = "https://github.com/ayu-theme/ayu-vim" },
    { src = "https://github.com/CantoroMC/ayu-nvim" },
})
vim.cmd.colorscheme "ayu"
vim.g.ayu_mirage = false
vim.g.guifont = "IosevkaTerm Nerd Font Mono"
vim.g.ayu_avoid_italics = true
--

local function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true })
end
LineNumberColors()

--
if vim.loop.os_uname().sysname == "Linux" then
    require("config_linux")
    require("reys.plugins.skeleton").setup({ path = vim.fn.expand("~/.config/nvim/skeletons/") })
else
    require("config_windows")
    require("reys.plugins.skeleton").setup({ path = vim.fn.expand("~/AppData/Local/nvim/skeletons/") })
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    -- Amazing minimal 0 deps plugin for snippets by: Erik
    -- https://blog.erikwastaken.dev/posts/2024-06-14-pluginless-neovim-snippets-in-42-lines-of-lua.html
end
--
vim.keymap.set('n', '<leader>is', require("reys.plugins.skeleton").show, {})

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
        vim.opt_local.tabstop = fileconfigs.tabstop         -- Number of spaces a tab represents
        vim.opt_local.shiftwidth = fileconfigs.shiftwidth   -- Number of spaces for each indentation
        vim.opt_local.expandtab = fileconfigs.expandtab     -- Convert tabs to spaces
        vim.opt_local.smartindent = fileconfigs.smartindent -- Automatically indent new lines
        foldmethod_guards(fileconfigs.foldmethod)
    end
end

local filetype_config = {
    md = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = false,
        smartindent = false,
        foldmethod = "manual",
    },
    markdown = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "manual",
    },
    mkd = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = false,
        smartindent = false,
        foldmethod = "manual",
    },
    latex = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "syntax",
    },
    tex = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "syntax",
    },
    bib = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "syntax",
    },
    lua = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    python = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    py = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    odin = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = false,
        smartindent = true,
        foldmethod = "syntax",
    },
    sh = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "syntax",
    },
    c = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = false,
        smartindent = true,
        foldmethod = "syntax",
    },
    cpp = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    h = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    zig = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    html = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    yaml = {
        tabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        smartindent = true,
        foldmethod = "syntax",
    },
    ex = {
        tabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    exs = {
        tabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    elixir = {
        tabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
    },
    js = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        foldmethod = "syntax",
    },
    json = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = false,
        foldmethod = "expr",
    },
}

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup('FormatBuffer', { clear = true }),
    callback = function(event)
        set_opt_local(filetype_config[vim.bo.filetype])
    end,
})

-- require("local_options")
