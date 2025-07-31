return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		dependencies = {
			{
			},
		},
		keys = {
			{"<leader>ff", "<cmd>Telescope find_files<CR>"},
			{"<leader>rg", "<cmd>Telescope live_grep<CR>"},
			{"<leader>qg", "<cmd>Telescope grep_string<CR>"},
			{"<leader>cs", "<cmd>Telescope colorscheme<CR>"},
			{"<leader>M", "<cmd>Telescope keymaps<CR>"},
			{"<leader>td", "<cmd>Telescope diagnostics<CR>"},
			{"<leader>h", "<cmd>Telescope help_tags<CR>"}
		},
		opts = function()
			return {
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--color", "never", "-g", "!.git" }
,
						hidden = true,
					},
				},
			}
		end,
	}
}
