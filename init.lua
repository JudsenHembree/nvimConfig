vim.cmd([[set runtimepath ^=/home/hybridos/nvim_memes/vimfims]])
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

-- basics
require("mason").setup()
require("telescope").setup()

-- github octo
-- require("octo").setup()

-- link harpoon
local harpoon = require('harpoon-config')
harpoon.binds()

-- setup clipboard
local clipboard = require('clipboard')
clipboard.setup()

-- setup lsp
local lsp = require('lsp-config')
lsp.setup()
lsp.setup_sort_of_lsp()

-- linter
local linter = require('linter')
linter.setup()

-- setup completion
local completion = require('completion')
completion.setup()

-- link other binds
require('keybinds')

-- vimfims plugin
utils.map('n', '<leader>vf', "<cmd>lua require('vimfims').tele_select()<CR>", {noremap=true})

-- set expandtab
vim.cmd('set shiftwidth=4')
vim.cmd('set expandtab')

-- let copilot markdown
vim.cmd('let g:copilot_filetypes = {"markdown": v:true}')

-- dap
local dap_config = require('dap-config')
dap_config.setup()

require("nvim-treesitter.configs").setup({
  ensure_installed = { "markdown", "markdown_inline", ... },
  highlight = {
    enable = true,
  },
})

