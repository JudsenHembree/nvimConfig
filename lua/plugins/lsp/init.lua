-- lsp bindings
vim.keymap.set('n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action({apply=true})<cr>")
vim.keymap.set('n', '<leader>gd', "<cmd>lua vim.lsp.buf.definition()<cr>") -- go to definition
vim.keymap.set('n', '<leader>qd', "<cmd>lua vim.lsp.buf.hover()<cr>") -- go to definition
vim.keymap.set('n', '<leader>in', "<cmd>lua vim.lsp.inlay_hint(0)<cr>") -- inlay hints toggle
vim.keymap.set('n', '<leader>rn', "<cmd>lua vim.lsp.buf.rename()<cr>") -- rename
vim.keymap.set('n', '<leader>qf', "<cmd>lua vim.lsp.buf.format()<cr>") -- rename
vim.keymap.set('n', '<leader>lw', "<cmd>lua vim.diagnostic.open_float()<cr>") -- lsp what? opens floating diag

return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig"
	},
	{
		"williamboman/mason.nvim",
		opts={}
	},
}
