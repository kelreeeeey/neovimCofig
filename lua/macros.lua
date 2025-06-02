local esc = vim.api.nvim_replace_termcodes( "<Esc>", true, true, true)

vim.fn.setreg("j", "vipJVgq")

vim.fn.setreg("f", "o\begin{figure}[ht!]\centering\includegraphics[]{}\end{figure}" .. esc)
