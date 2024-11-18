local utils = require('utils')

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
