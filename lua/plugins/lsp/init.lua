local function format_file(file)
    vim.cmd('edit ' .. file)  -- Open the file in the current buffer
    print("Opened and formatting file: " .. file)

    -- Call LSP formatting for the current buffer
    vim.lsp.buf.format({
        timeout_ms = 5000,  -- Timeout after 5 seconds
    })
end

local function traverse_directory(path)
    local uv = vim.loop
    local handle = uv.fs_scandir(path)

    while true do
        local name, type = uv.fs_scandir_next(handle)
        if not name then break end

        local full_path = path .. '/' .. name

        if type == 'directory' then
            traverse_directory(full_path)  -- Recursively traverse subdirectories
        elseif type == 'file' then
            if name:match("%.cpp$") or name:match("%.h$") then
                format_file(full_path)  -- Open and format .cpp and .h files
            end
        end
    end
end

local function format_all_files()
    local root_dir = vim.fn.getcwd()  -- Get the current working directory
    traverse_directory(root_dir)      -- Start traversing from the root directory
end

vim.api.nvim_create_user_command('FormatCppHFiles', format_all_files, {})

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

				-- Zig
				require'lspconfig'.zls.setup{}

				-- lsp bindings
				vim.keymap.set('n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action({apply=true})<cr>")
				vim.keymap.set('n', '<leader>gd', "<cmd>lua vim.lsp.buf.definition()<cr>") -- go to definition
				vim.keymap.set('n', '<leader>qd', "<cmd>lua vim.lsp.buf.hover()<cr>") -- go to definition
				vim.keymap.set('n', '<leader>in', "<cmd>lua vim.lsp.inlay_hint(0)<cr>") -- inlay hints toggle
				vim.keymap.set('n', '<leader>rn', "<cmd>lua vim.lsp.buf.rename()<cr>") -- rename
				vim.keymap.set('n', '<leader>FF', format_all_files, { silent = true }) -- rename
			end
		},
	}
},
}
