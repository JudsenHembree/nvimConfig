return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = "LazyFile",
		dependencies = {
			"mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", config = function() end },
		}
	},

	-- cmdline tools and lsp servers
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
	},
}
