vim.g.mapleader = " "

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true

vim.keymap.set("n", "<leader>pv", ":ex<cr>")
-- vim.keymap.set("n", "C-h", ":ex<cr>")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>")
