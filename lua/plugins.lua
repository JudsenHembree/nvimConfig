-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim' -- plugin manager
  use "EdenEast/nightfox.nvim" -- close to synth with duskfox
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP


  -- telescope is fuzzy finder and such
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- treesitter improves syntax
  use {
	  "nvim-treesitter/nvim-treesitter",
	  run = ":TSUpdate",
  }

  -- nvim completion
  use {
	  "hrsh7th/nvim-cmp",
	  requires = {
		  'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 
		  'hrsh7th/cmp-cmdline', 'hrsh7th/nvim-cmp', 'L3MON4D3/LuaSnip', 
		  'saadparwaiz1/cmp_luasnip'
	  }
  }

  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} } -- debugger :chad:
  use 'leoluz/nvim-dap-go' -- auto config for go dap
 
end)
