-- GOLANG
-- set up lsp
	require'lspconfig'.gopls.setup{} --setup gopls
-- lint on write
	local function lspLint()
		vim.lsp.buf.formatting()
	end
	vim.api.nvim_create_autocmd({"BufWritePre"}, {
		pattern = {"*go"},
		callback = lspLint,
	})


-- Python
-- set up lsp
	require'lspconfig'.pyright.setup{} --setup gopls
-- lint on write
	local function pylspLint()
		vim.lsp.buf.formatting()
	end
	vim.api.nvim_create_autocmd({"BufWritePre"}, {
		pattern = {"*py"},
		callback = pylspLint,
	})

--c/cpp/rust
	require'lspconfig'.clangd.setup{} --setup gopls

	-- lint on write
		local function cpplspLint()
			vim.lsp.buf.formatting()
		end
		vim.api.nvim_create_autocmd({"BufWritePre"}, {
			pattern = {"c, cpp, cu, rust"},
			callback = cpplspLint,
		})
	
