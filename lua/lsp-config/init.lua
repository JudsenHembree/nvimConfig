local lsp = {}

function lsp.setup()
	require'lspconfig'.gopls.setup{} --setup gopls
	require'lspconfig'.pyright.setup{} --setup pyright
	require'lspconfig'.clangd.setup{} --setup clangd 
        require'lspconfig'.rust_analyzer.setup{}
        require'lspconfig'.hls.setup{}
        require'lspconfig'.zls.setup{}
        require'lspconfig'.ts_ls.setup{}
        -- require'lspconfig'.lua-language-server.setup{}
end

function lsp.setup_sort_of_lsp()
    require'glow'.setup{}
end

return lsp
