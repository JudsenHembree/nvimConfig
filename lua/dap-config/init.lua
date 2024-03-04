local utils = require('utils')
local dap = require("dap")
local dap_ui = require('dapui')

local dap_config = {}

function handle_mapping()
    utils.map("n", "<leader>b", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", opts)
    utils.map("n", "<leader>c", "<CMD>lua require'dap'.continue()<CR>", opts)
    utils.map("n", "<leader>s", "<CMD>lua require'dap'.step_into()<CR>", opts)
    utils.map("n", "<leader>S", "<CMD>lua require'dap'.step_over()<CR>", opts)
    utils.map("n", "<leader>O", "<CMD>lua require'dap'.step_out()<CR>", opts)
    utils.map("n", "<leader>td", "<CMD>lua require'dapui'.toggle()<CR>", opts)
    utils.map("n", "<leader>te", "<CMD>lua require'dapui'.eval()<CR>", opts)
    utils.map("n", "<leader>tw", "<CMD>lua require'dapui'.elements.watches.add()<CR>", opts)
end


function setup_servers()
    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
    }
end


function configure()
    dap.configurations.cpp = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = "${workspaceFolder}",
        },
    }

    dap.configurations.zig = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = "${workspaceFolder}",
        },
    }

end

dap_config.setup = function()
    setup_servers()
    configure()
    dap_ui.setup() -- ui for dap
    handle_mapping()
end

return dap_config
