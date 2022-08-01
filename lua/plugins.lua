-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "EdenEast/nightfox.nvim" -- close to synth with duskfox
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP


  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
	  "nvim-treesitter/nvim-treesitter",
	  run = ":TSUpdate",
  }

end)