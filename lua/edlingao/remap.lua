vim.g.mapleader = " "

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true

vim.keymap.set("n", "<leader>pv", ":ex<cr>")
-- vim.keymap.set("n", "C-h", ":ex<cr>")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>")

vim.api.nvim_create_user_command("TemplFmt", function()
    vim.cmd("silent !templ fmt " .. vim.fn.expand("%:p"))
end, {})

-- Set relative numbers on by default
vim.cmd("set relativenumber")

vim.api.nvim_create_autocmd({'BufWritePost'}, {
  pattern = {'*.templ'},
  command = "TemplFmt",
})

vim.api.nvim_create_autocmd({'BufWritePost'}, {
  pattern = {'*.go'},
  command = "silent GoFmt",
})
