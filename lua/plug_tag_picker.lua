local tag_picker = require('tag_picker') -- comes after telescope
vim.keymap.set('n', '<leader>t', tag_picker.tag_search_picker, { desc = "Search tags" })
