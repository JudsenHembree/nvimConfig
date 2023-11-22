local lsp = {}

function lsp.setup()
	require'lspconfig'.gopls.setup{} --setup gopls
	require'lspconfig'.pyright.setup{} --setup pyright
        require'lspconfig'.tsserver.setup{} --setup tsserver
	require'lspconfig'.clangd.setup{} --setup clangd 
        require'lspconfig'.rust_analyzer.setup{}
end

function lsp.setup_sort_of_lsp()
    require'glow'.setup{}
end

return lsp
