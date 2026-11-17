-- Debugging: nvim-dap + dap-ui, gdb's built-in DAP mode (gdb >= 14) for C/C++/Zig/Rust.
-- Moved under <leader>d (the old <leader>c "continue" clashed with the clipboard/code keys).
local function dap(fn) return function() require("dap")[fn]() end end

local function launch_config()
    return {
        name = "Launch (gdb)",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input({ prompt = "Path to executable: ", default = vim.fn.getcwd() .. "/", completion = "file" })
        end,
        args = function()
            return vim.split(vim.fn.input("Args: "), " ", { trimempty = true })
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    }
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
        },
        keys = {
            { "<leader>db", dap("toggle_breakpoint"), desc = "Toggle breakpoint" },
            { "<leader>dc", dap("continue"),          desc = "Continue / start" },
            { "<leader>di", dap("step_into"),         desc = "Step into" },
            { "<leader>do", dap("step_over"),         desc = "Step over" },
            { "<leader>dO", dap("step_out"),          desc = "Step out" },
            { "<leader>dC", dap("run_to_cursor"),     desc = "Run to cursor" },
            { "<leader>dr", dap("run_last"),          desc = "Run last" },
            { "<leader>dq", dap("terminate"),         desc = "Stop" },
            { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
            { "<leader>de", function() require("dapui").eval() end,   desc = "Eval", mode = { "n", "v" } },
            { "<leader>dw", function() require("dapui").elements.watches.add() end, desc = "Add watch" },
            { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover value" },
        },
        config = function()
            local d, ui = require("dap"), require("dapui")
            ui.setup()

            d.adapters.gdb = { type = "executable", command = "gdb", args = { "-i", "dap" } }
            for _, ft in ipairs({ "c", "cpp", "zig", "rust" }) do
                d.configurations[ft] = { launch_config() }
            end

            d.listeners.before.attach.dapui_config = function() ui.open() end
            d.listeners.before.launch.dapui_config = function() ui.open() end
            d.listeners.before.event_terminated.dapui_config = function() ui.close() end
            d.listeners.before.event_exited.dapui_config = function() ui.close() end

            -- the breakpoint sign stays sus
            vim.fn.sign_define("DapBreakpoint", { text = "ඞ", texthl = "DapBreakpoint" })
            vim.fn.sign_define("DapStopped", { text = "󰁕", texthl = "DapStopped", linehl = "CursorLine" })
        end,
    },
}
