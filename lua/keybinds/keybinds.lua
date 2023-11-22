local utils = require('utils')

-- telescope bindings
utils.map('n', '<leader>rg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
utils.map('n', '<leader>qg', "<cmd>lua require('telescope.builtin').grep_string()<cr>")
utils.map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>")
utils.map('n', '<leader>keys', "<cmd>lua require('telescope.builtin').keymaps()<cr>")
utils.map('n', '<leader>dd', "<cmd>lua require('telescope.builtin').diagnostics()<cr>")

-- lsp bindings
utils.map('n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action({apply=true})<cr>") -- code action
utils.map('n', '<leader>gd', "<cmd>lua vim.lsp.buf.definition()<cr>") -- go to definition
utils.map('n', '<leader>qd', "<cmd>lua vim.lsp.buf.hover()<cr>") -- go to definition
utils.map('n', '<leader>in', "<cmd>lua vim.lsp.inlay_hint(0)<cr>") -- inlay hints toggle
utils.map('n', '<leader>rn', "<cmd>lua vim.lsp.buf.rename()<cr>") -- rename
