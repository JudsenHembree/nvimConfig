local config_home = os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"
config_home = config_home .. "/nvim"
package.path = package.path .. ";" .. config_home .. "/lua/utils/?.lua;" .. config_home .. "/lua/general-appearance/?.lua;" .. config_home .. "/lua/keybinds/?.lua;" .. config_home .. "/?.lua"
require('plugins')

-- link utils
	local utils = require('utils')
-- link appearance
	local appearance = require('appearance')
	-- apply general-appearance
	appearance.set_scheme('tokyonight-night')
-- link auto-install
	local auto_install = require('auto-install')
	auto_install.auto()

-- link other binds
	require('keybinds')

-- test function
	utils.map('n', '<leader>tt', ":lua require('auto-install').auto()<CR>")

	require("mason").setup()
	require("telescope").setup()
