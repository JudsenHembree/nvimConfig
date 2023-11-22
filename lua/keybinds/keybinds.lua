local utils = require('utils')

utils.map('n', '<leader>rg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
utils.map('n', '<leader>qg', "<cmd>lua require('telescope.builtin').grep_string()<cr>")
utils.map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>")
utils.map('n', '<leader>keys', "<cmd>lua require('telescope.builtin').keymaps()<cr>")
utils.map('n', '<leader>dd', "<cmd>lua require('telescope.builtin').diagnostics()<cr>")
utils.map('n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action({apply=true})<cr>")
