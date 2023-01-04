-- link utils
local utils = require("utils")
-- telescope
	local telescope = require("telescope")
	utils.map("n", "<leader>ff", "<CMD>lua require'telescope.builtin'.find_files()<CR>", opts)
	utils.map("n", "<leader>of", "<CMD>lua require'telescope.builtin'.oldfiles()<CR>", opts)
	utils.map("n", "<leader>cs", "<CMD>lua require'telescope.builtin'.colorscheme()<CR>", opts)
	utils.map("n", "<leader>M", "<CMD>lua require'telescope.builtin'.keymaps()<CR>", opts)
	utils.map("n", "<leader>K", "<CMD>lua require'telescope.builtin'.lsp_definitions({jump_type = 'never'})<CR>", opts)
	-- utils.map("n", "<leader>H", ":lua require'telescope.builtin'.commands()<CR>", opts) -- seems kinda not useful
	utils.map("n", "<leader>d", "<CMD>lua require'telescope.builtin'.diagnostics()<CR>", opts) 
	utils.map("n", "<leader>h", "<CMD>Telescope help_tags<CR>", opts) 

