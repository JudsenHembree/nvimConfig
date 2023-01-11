local lsp = {}
function lsp.setup()
	require'lspconfig'.gopls.setup{} --setup gopls
	require'lspconfig'.pyright.setup{} --setup gopls
	require'lspconfig'.clangd.setup{} --setup gopls
end

return lsp
