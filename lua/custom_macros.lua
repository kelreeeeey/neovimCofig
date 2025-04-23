local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

-- Odin fmt

vim.api.nvim_create_augroup("OdinFmtMacro", {clear=true})
vim.api.nvim_create_autocmd("FileType", {
    group = "OdinFmtMacro",
    pattern = { "odin", "go" },
    callback = function()
        vim.fn.setreg(
            "p",
            "yofmt.printfln('" .. esc .. "pa:" .. esc .. "la, " .. esc .. "pl")
    end
})

