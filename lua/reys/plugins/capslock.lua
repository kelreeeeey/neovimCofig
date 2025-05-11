return {
        "barklan/capslock.nvim",
        lazy = false,
        -- keys = {
        --     { "<S-l>", "<Plug>CapsLockToggle", mode = { "i", "c" } },
        --     { "<leader>c", "<Plug>CapsLockToggle", mode = { "n" } },
        -- },
        -- config = true,
        -- require("capslock").setup()
        config = function()
            require("capslock").setup()
            vim.keymap.set({ "i", "c", "n" }, "<C-g>c", "<Plug>CapsLockToggle")
        end,
}
