return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = function() require("mason").setup() end  },
			{ "williamboman/mason-lspconfig.nvim", config = function() end },
		}
	},
}
