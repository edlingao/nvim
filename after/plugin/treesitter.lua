require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    "vimdoc",
    "javascript",
    "typescript",
    "rust",
    "go",
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "html",
    "templ",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

vim.treesitter.language.register("html", "ejs")
vim.treesitter.language.register("javascript", "ejs")
vim.filetype.add({ extension = { templ = "templ" } })

vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.templ", callback = function() vim.cmd("TSBufEnable highlight") end })

-- Explicitly register and enable Ripple tree-sitter with TSX highlighting
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile", "BufEnter"}, {
  pattern = "*.ripple",
  callback = function(args)
    vim.bo[args.buf].filetype = "ripple"
    -- Start tree-sitter with additional vim syntax highlighting
    vim.treesitter.start(args.buf, "ripple")
    vim.api.nvim_buf_set_option(args.buf, "syntax", "on")
  end
}) 

