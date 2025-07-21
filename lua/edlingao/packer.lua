-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
  	"catppuccin/nvim",
	as = "catppuccin",
	config = function()
		vim.cmd('colorscheme catppuccin')
	end
  }

  use('nvim-treesitter/nvim-treesitter',{ run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment these if you want to manage LSP servers from neovim
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
	  }
  }
  use {
  	'christoomey/vim-tmux-navigator',
	lazy=false,
  }

  use('nvim-tree/nvim-tree.lua');
  use('nvim-tree/nvim-web-devicons');
  use('github/copilot.vim');
  use('mhinz/vim-signify');
  use('tpope/vim-surround');
  use('darrikonn/vim-gofmt')
  use('luckasRanarison/tailwind-tools.nvim')
  use('mfussenegger/nvim-lint')
end)
