-- Ripple files: Use Tree-sitter with TypeScript queries inheritance
local buf = vim.api.nvim_get_current_buf()

-- Load TypeScript and TSX parsers to ensure they're available
pcall(vim.treesitter.language.add, "typescript")
pcall(vim.treesitter.language.add, "tsx")

-- Start Ripple tree-sitter with additional vim regex highlighting
vim.bo[buf].syntax = ""  -- Clear syntax
vim.treesitter.start(buf, "ripple")

-- Ensure Tailwind LSP starts for ripple files
vim.defer_fn(function()
  local clients = vim.lsp.get_clients({ bufnr = buf, name = "tailwindcss" })
  if #clients == 0 then
    vim.lsp.start({
      name = "tailwindcss",
      cmd = { "tailwindcss-language-server", "--stdio" },
      root_dir = vim.fs.root(buf, { "tailwind.config.js", "tailwind.config.ts", "package.json" }),
    })
  end
end, 100)

-- Manually define keyword matches using vim.fn.matchadd for fallback
vim.api.nvim_create_autocmd("BufWinEnter", {
  buffer = buf,
  once = true,
  callback = function()
    local keywords = {
      "import", "export", "from", "as", "const", "let", "var",
      "function", "class", "extends", "if", "else", "for", "while",
      "do", "switch", "case", "default", "break", "continue",
      "return", "try", "catch", "finally", "throw", "of", "in",
      "typeof", "instanceof", "new", "this", "super", "async", "await"
    }
    local pattern = "\\<\\(" .. table.concat(keywords, "\\|") .. "\\)\\>"
    vim.fn.matchadd("Keyword", pattern)
  end
})
