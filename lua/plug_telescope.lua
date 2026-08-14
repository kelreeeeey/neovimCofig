local keymap = vim.keymap
vim.pack.add({
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
})

-- # Telescope

require("telescope").setup({
    defaults = {
        layout_config = {
          vertical = { width = 0.5 }
          -- other layout configuration here
        },
    },
    pickers = {
        find_files = { theme = "dropdown", },
        buffers = { theme = "dropdown", },
    },
})
local builtin = require('telescope.builtin')
local tl_themese = require('telescope.themes')

keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
keymap.set('n', '<leader>fff', builtin.grep_string, { desc = 'Telescope Grep string' })
keymap.set('n', "<leader><leader>", builtin.buffers, { desc = 'Telescope buffers' })
keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
keymap.set('n', '<leader>ft', builtin.tags, { desc = 'Telescope Tags' })
keymap.set('n', '<leader>fq', builtin.quickfix, { desc = 'Telescope Quickfix' })


