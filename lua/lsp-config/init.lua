local lsp = {}
function lsp.setup()
	require'lspconfig'.gopls.setup{} --setup gopls
	require'lspconfig'.pyright.setup{} --setup gopls
	require'lspconfig'.clangd.setup{} --setup gopls
end
-- GOLANG
-- set up lsp
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
-- lint on write
	local function pylspLint()
		vim.lsp.buf.formatting()
	end
	vim.api.nvim_create_autocmd({"BufWritePre"}, {
		pattern = {"*py"},
		callback = pylspLint,
	})

--c/cpp/rust

	-- lint on write
		local function cpplspLint()
			vim.lsp.buf.formatting()
		end
		vim.api.nvim_create_autocmd({"BufWritePre"}, {
			pattern = {"c, cpp, cu, rust"},
			callback = cpplspLint,
		})
	
return lsp
