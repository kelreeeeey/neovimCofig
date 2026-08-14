vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
})

require("oil").setup({
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    use_default_keymaps = true,

    columns = { "ctime", "mtime" },

    lsp_file_methods = {
        enabled = true,
        autosave_changes = true
    },

    win_options = {
        wrap = true,
        signcolumn = "no",
        cursorcolumn = false,
        conceallevel = 3,
        concealcursor = "nvic",
        spell = false,
        list = true,
    },

    keymaps = {
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["gx"] = "actions.open_external",
        ["<Esc>"] = "actions.close",
        ["q"] = "actions.close",
    },

    float = {
        padding = 4,
        max_width = 100,
        max_height = 80,
        border = "rounded",
        win_options = {
            winblend = 0
        }
    },

    view_options = {
        show_hidden = false,
        is_always_hidden = function(name, _)
            return name == ".." or name == ".git"
        end,
        natural_order = "fast",
        case_insensitive = false,
        sort = {
            { "type", "asc" },
            { "name", "asc" },
        },
        highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
            return nil
        end,
    }
})
vim.keymap.set("n", "|", "<CMD>Oil<CR>", { desc = "Open parent directory in floating window" })
vim.keymap.set("n", "\\", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

