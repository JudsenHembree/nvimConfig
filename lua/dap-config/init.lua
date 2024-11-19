local utils = require('utils')
local dap = require("dap")
local dap_ui = require('dapui')

local dap_config = {}

function handle_mapping()

--  run_to_cursor()                                            *dap.run_to_cursor()*
--          Continues execution to the current cursor.
--  
--          This temporarily removes all breakpoints, sets a breakpoint at the
--          cursor, resumes execution and then adds back all breakpoints again.
    utils.map("n", "<leader>rc", "<CMD>lua require'dap'.run_to_cursor()<CR>", opts)
end

function setup_signs()
  vim.fn.sign_define('DapBreakpoint', {text='ඞ', texthl='', linehl='', numhl=''})
end


function setup_servers()
    local dap = require("dap")
    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
    }
end


function configure()
    local dap = require("dap")

    dap.configurations.cpp = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            args = function()
                -- use split later
                return vim.fn.input('Args: ', ' ', 'file')
            end,
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
        },

    }

    dap.configurations.zig = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
                return vim.fn.input({
                    prompt = 'Path to executable: ', 
                    default = vim.fn.getcwd() .. '/', 
                    completion = 'file'
                })
            end,
            cwd = "${workspaceFolder}",
        },
    }
end

function setup_listeners()
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
        utils.map("n", "<leader>K", "<CMD>lua require('dap.ui.widgets').hover()<CR>", opts)
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end
end

dap_config.setup = function()
    setup_servers()
    configure()
    dap_ui.setup() -- ui for dap
    setup_listeners() -- auto open
    setup_signs() -- amogus
    handle_mapping()
end

return dap_config
