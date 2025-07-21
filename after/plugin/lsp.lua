local lsp_zero = require('lsp-zero')

-- Setup the default keymaps
-- This will setup the default keymaps for the current buffer
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})

local mason_lspconfig = require('mason-lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Set up filetypes for .templ files
vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

mason_lspconfig.setup({
  ensure_installed = {
    'rust_analyzer',
    'lua_ls',
    'ts_ls',
    'eslint',
    'tailwindcss',
    'html',
    'templ',
    'emmet_ls',
    'gopls',
  },
  handlers = {
    function(server_name)
      print("Setting up " .. server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
      })
    end,

    ["emmet-ls"] = function()
      print("Setting up emmet_ls")
      -- Setup emmet_ls with specific filetypes
      require("lspconfig").emmet_ls.setup({
        capabilities = capabilities,
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "templ",
        },
      })
    end,

    ["htmx"] = function()
      print("Setting up htmx")
      -- Setup htmx with specific filetypes
      require("lspconfig").htmx.setup({
        capabilities = capabilities,
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "templ",
        },
      })
    end,
  }
})

require("lspconfig").emmet_ls.setup({
  capabilities = capabilities,
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "templ",
  },
})

require("lspconfig").htmx.setup({
  capabilities = capabilities,
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "templ",
  },
})

