local esc = vim.api.nvim_replace_termcodes( "<Esc>", true, true, true)
local enter = vim.api.nvim_replace_termcodes( "<Enter>", true, true, true )


vim.api.nvim_create_augroup("TextEditing", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "TextEditing",
    pattern = { "markdown", ".md", "latex", ".tex", ".bib", ".text", "plaintext" },
    callback = function()
        vim.fn.setreg("j", "vipJVgq$")
    end
})


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
    pattern = { "*.json" },
    callback = function()
        vim.fn.setreg("p", [[o{
"name" : "Default",
"label" : "Default",
"description" : "Default",
"type" : "Default",
"defaultValue" : "Default",
"mandatory" : true
},]])

        vim.fn.setreg("i", [[o{
"name" : "Default",
"label" : "Default",
"description" : "Default",
"type" : "INT",
"defaultValue" : 10,
"mandatory" : true
},]])

        vim.fn.setreg("d", [[o{
"name" : "Default",
"label" : "Default",
"description" : "Default",
"type" : "DOUBLE",
"defaultValue" : 10.0,
"mandatory" : true
},]])

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
},]])

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
},]])

    end
})


local headpython = [[i# coding: utf-8 -*-
#:put =strftime('# Created at: %a %Y-%m-%d %H:%M:%S%z')o#
# Author: Kelrey
# Email: taufiqkelrey1@gmail.com
# Github: kelreeeey
"""Description
"""

def main() -> int:

return 0

if __name__ == '__main__':
main()]]

local marimo_sandbox = [[i# /// script
# requires-python = ">=3.10"
# dependencies = [
#     "marimo==0.14.12",
#     "altair==4.2.0",
#     "matplotlib",
#     "hvplot",
#     "scipy",
#     "numpy>=1.26.4",
#     "polars>=0.20.31"
# ]
# ///]]

vim.fn.setreg("f", ":r!echo %0i ")

vim.api.nvim_create_augroup("PythonDev", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "PythonDev",
    pattern = { "python", },
    callback = function()
        vim.fn.setreg("d",  headpython .. esc .. "11kO# File:" .. esc .. "@f")
        vim.fn.setreg("r",  ":!ruff format %" .. enter)
        vim.fn.setreg("m",  marimo_sandbox .. esc)
    end
})




