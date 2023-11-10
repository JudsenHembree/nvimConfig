local lsp = {}

function lsp.setup()
	require'lspconfig'.gopls.setup{} --setup gopls
	require'lspconfig'.pyright.setup{} --setup pyright
        require'lspconfig'.tsserver.setup{} --setup tsserver
	require'lspconfig'.clangd.setup{
		capabilities = capabilities,
		before_init = before_init_process_id_nil,
		cmd = clangd,
		on_new_config = on_new_config,
		on_attach = on_attach,
	} 
        require'lspconfig'.rust_analyzer.setup{}
end

function lsp.setup_sort_of_lsp()
    require'glow'.setup{}
end

return lsp
