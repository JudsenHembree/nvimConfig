package.path = package.path .. ";./lua/utils/?.lua;./lua/general-appearance/?.lua;"
require('plugins')
require('completion')

-- link utils
	local utils = require('utils')
-- link appearance
	local appearance = require('appearance')
	-- apply general-appearance
	appearance.set_scheme('tokyonight-night')
-- link auto-install
	local auto_install = require('auto-install')
	auto_install.auto()

-- test function
	--utils.map('n', '<leader>tt', ":lua require('auto-install').ripgrep()<CR>")
