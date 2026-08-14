vim.pack.add({
    { src = "https://github.com/kdheepak/lazygit.nvim", }, -- requires plenary
})

require("lazygit")
vim.keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>", { desc = "LazyGit" })
vim.keymap.set("n", "<leader>ggc", "<CMD>LazyGitCurrentFile<CR>", { desc = "LazyGitCurrentFile" })
vim.keymap.set("n", "<leader>ggf", "<CMD>LazyGitFilter<CR>", { desc = "LazyGitFilter" })
