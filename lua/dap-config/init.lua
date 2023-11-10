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
end


function setup_servers()
    dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
        name = 'lldb'
    }
end


function configure()
    dap.configurations.cpp = {
        {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},

            -- 💀
            -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
            --
            --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            --
            -- Otherwise you might get the following error:
            --
            --    Error on launch: Failed to attach to the target process
            --
            -- But you should be aware of the implications:
            -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
            -- runInTerminal = false,
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
