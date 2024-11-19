return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = function() require("mason").setup() end  },
			{ "williamboman/mason-lspconfig.nvim",
			config = function()
				require("mason-lspconfig").setup_handlers {
					function (server_name)
						require("lspconfig")[server_name].setup {}
					end,
				}
				-- lsp bindings
				vim.keymap.set('n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action({apply=true})<cr>")
				vim.keymap.set('n', '<leader>gd', "<cmd>lua vim.lsp.buf.definition()<cr>") -- go to definition
				vim.keymap.set('n', '<leader>qd', "<cmd>lua vim.lsp.buf.hover()<cr>") -- go to definition
				vim.keymap.set('n', '<leader>in', "<cmd>lua vim.lsp.inlay_hint(0)<cr>") -- inlay hints toggle
				vim.keymap.set('n', '<leader>rn', "<cmd>lua vim.lsp.buf.rename()<cr>") -- rename
			end
		},
	}
},
}
