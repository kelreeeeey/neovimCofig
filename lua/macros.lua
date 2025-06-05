local esc = vim.api.nvim_replace_termcodes( "<Esc>", true, true, true)

vim.fn.setreg("j", "vipJVgq$")

--[[
-- vim.api.nvim_create_augrop("LaTeXMacros", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--     group = "LaTeXMacros",
--     pattern = { "latex", "bib", "tex", "bibtex" },
--     callback = function()
--         vim.fn.setreg("f", "o\\begin{figure}[ht!]\\centering\\includegraphics[width=\\textwidth, keepaspectratio]{}\end{figure}" .. esc)
--         vim.fn.setreg("F", "o\\begin{figure}[ht!]\\centering\\includegraphics[width=\\textwidth, keepaspectratio]{}\input{}\end{figure}" .. esc)
--     end
-- })
--]]

vim.api.nvim_create_augroup("JSONDataiku", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "JSONDataiku",
    pattern = { "json" },
    callback = function()

        vim.fn.setreg("p", [[o{
"name" : "Default",
"label" : "Default",
"description" : "Default",
"type" : "Default",
"defaultValue" : "Default",
"mandatory" : true
}]])

        vim.fn.setreg("i", [[o{
"name" : "Default",
"label" : "Default",
"description" : "Default",
"type" : "INT",
"defaultValue" : 10,
"mandatory" : true
}]])

        vim.fn.setreg("d", [[o{
"name" : "Default",
"label" : "Default",
"description" : "Default",
"type" : "DOUBLE",
"defaultValue" : 10.0,
"mandatory" : true
}]])

        vim.fn.setreg("o", [[o{
"name" : "Default",
"label" : "Default",
"description" : "Default",
"type" : "OBJECT_LIST",
"subParams": [
  {
    "name" : "Default1",
    "label" : "Default1",
    "description" : "Default",
    "type" : "Default",
    "defaultValue" : "Default",
    "mandatory" : true
  },
  {
    "name" : "Default2",
    "label" : "Default2",
    "description" : "Default",
    "type" : "Default",
    "defaultValue" : "Default",
    "mandatory" : true
  },
],
"defaultValue" : "Default1",
"mandatory" : true
}]])

        vim.fn.setreg("s", [[o{
"name": "Default",
"label": "Default",
"description": "Default",
"type": "SELECT",
"selectChoices" : [
  {
    "name" : "Default1",
    "label" : "Default1",
    "description" : "Default",
    "type" : "Default",
    "defaultValue" : "Default",
    "mandatory" : true
  },
  {
    "name" : "Default2",
    "label" : "Default2",
    "description" : "Default",
    "type" : "Default",
    "defaultValue" : "Default",
    "mandatory" : true
  },
],
"defaultValue": "Default1",
"mandatory": true
}]])

    end
})

