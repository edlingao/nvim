local lsp_zero = require('lsp-zero')

-- Setup the default keymaps
-- This will setup the default keymaps for the current buffer
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', {})

-- Auto-format on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.templ" },
  callback = vim.lsp.buf.format
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.ts", "*.js", "*.jsx", "*.tsx", "*.ripple" },
  callback = function()
    local filepath = vim.api.nvim_buf_get_name(0)
    -- Find package.json to determine project root
    local package_json = vim.fn.findfile("package.json", vim.fn.expand("%:p:h") .. ";")
    local project_root = vim.fn.fnamemodify(package_json, ":h")

    -- Run prettier from the project root where node_modules exists
    local cmd = string.format("cd %s && prettier --write %s 2>&1",
      vim.fn.shellescape(project_root),
      vim.fn.shellescape(filepath))

    local result = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
      print("Prettier error: " .. result)
    else 
      -- Reload the buffer to reflect changes
      vim.api.nvim_command("edit!")
    end
  end
})

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Set up filetypes for .templ and .ripple files
vim.filetype.add({
  extension = {
    templ = "templ",
    ripple = "ripple",
  },
})

-- Configure default settings for all LSP servers
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Configure emmet_ls with specific filetypes
vim.lsp.config('emmet_ls', {
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
    "ripple",
  },
})

-- Configure htmx with specific filetypes
vim.lsp.config('htmx', {
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

-- Configure Tailwind CSS with ripple and templ support
vim.lsp.config('tailwindcss', {
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
    "ripple",
  },
  root_markers = { 'tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js', 'package.json' },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "class\\s*[=:]\\s*['\"]([^'\"]*)['\"]" },
          { "className\\s*[=:]\\s*['\"]([^'\"]*)['\"]" },
        },
      },
      includeLanguages = {
        ripple = "html",
        templ = "html",
        typescript = "javascript",
        typescriptreact = "html",
      },
    },
  },
})

vim.lsp.enable('tailwindcss')

-- Configure Ripple language server
vim.lsp.config('ripple', {
  cmd = { 'ripple-language-server', '--stdio' },
  filetypes = { 'ripple' },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
})

vim.lsp.enable('ripple')

-- Mason-lspconfig setup with automatic_enable
-- This will automatically enable all installed servers
require('mason-lspconfig').setup({
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
})

