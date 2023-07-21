-- shorten cmd syntax with local
local cmd = vim.api.nvim_command 
-- auto install packer if needed
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
	  fn.system({
	    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
	  })
	  vim.api.nvim_command('packadd packer.nvim')
	end
-- Only required if you have packer configured as `opt`
	vim.cmd [[packadd packer.nvim]]

-- startup
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim' -- plugin manager

  -- harpoon navigation
  use {
      "ThePrimeagen/harpoon",
      config = function()
          require("harpoon").setup()
      end
  }

  -- plugin for clipboard
  use {
      'ojroques/nvim-osc52'
  }

  -- cmp
  use {
    'hrsh7th/nvim-cmp',
    requires = {
	'neovim/nvim-lspconfig',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	'L3MON4D3/LuaSnip',
	'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require('completion')
    end
  }

  -- colorscheme
  use {'folke/tokyonight.nvim'}  -- Tokyo bby
  --use "EdenEast/nightfox.nvim" -- close to synth with duskfox

  -- lsp
  use {'neovim/nvim-lspconfig',
  	config = "require('lsp-config')"
	} -- Configurations for Nvim LSP
  -- lsp in docker
  use {'lspcontainers/lspcontainers.nvim'}

  -- linter
  use {'mfussenegger/nvim-lint'}

  -- Copilot
  use {'github/copilot.vim'}

  -- tmux and neovim window swaps
  use {
	"christoomey/vim-tmux-navigator"
  }

  -- markdown preview
  use {
	  "ellisonleao/glow.nvim",
	  config = function() require("glow").setup() end,
  }

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use { "williamboman/mason.nvim",
  	config = require("mason-config")
  }

  -- telescope is fuzzy finder and such
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  requires = { {'nvim-lua/plenary.nvim'} },
  }

  -- treesitter improves syntax
  use {
	  "nvim-treesitter/nvim-treesitter",
	  run = ":TSUpdate",
  }

  -- work in progress
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} } -- debugger :chad:
  use 'leoluz/nvim-dap-go' -- auto config for go dap

  -- latex integration
  use { 'lervag/vimtex' }
end)
