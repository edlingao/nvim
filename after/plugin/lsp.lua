local lsp_zero = require('lsp-zero')

-- Setup the default keymaps
-- This will setup the default keymaps for the current buffer


vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', {})


lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})

local mason_lspconfig = require('mason-lspconfig')

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format({
      bufnr = bufnr,
      filter = function(client)
    	  return client.name == "null-ls"
      end
    })
    print("File formatted")
  end, { desc = 'Format current buffer with LSP' })
end

mason_lspconfig.setup({
  ensure_installed = {
    'rust_analyzer',
    'lua_ls',
    'tsserver',
    'eslint',
    'emmet_ls',
    'haxe_language_server',
    'tailwindcss',
    'html',
    'denols',
    'gopls',
  },
  handlers = {
    lsp_zero.default_setup,
  },
});

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      on_attach = on_attach,
    }
  end,
}


local nvim_lsp = require('lspconfig')
nvim_lsp.denols.setup {
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
}

