local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'rust_analyzer', 'lua_ls', 'tsserver', 'eslint', 'emmet_ls', 'haxe_language_server'},
  handlers = {
    lsp_zero.default_setup,
  },
})
