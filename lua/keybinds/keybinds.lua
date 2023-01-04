local utils = require('utils')

utils.map('n', '<leader>rg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
