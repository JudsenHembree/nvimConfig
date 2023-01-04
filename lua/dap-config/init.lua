-- debugging
	-- mapping
		utils.map("n", "<leader>b", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", opts)
		utils.map("n", "<leader>c", "<CMD>lua require'dap'.continue()<CR>", opts)
		utils.map("n", "<leader>s", "<CMD>lua require'dap'.step_into()<CR>", opts)
		utils.map("n", "<leader>S", "<CMD>lua require'dap'.step_over()<CR>", opts)
		utils.map("n", "<leader>O", "<CMD>lua require'dap'.step_out()<CR>", opts)

	require("dap")
	require("dapui").setup() -- ui for dap
	require'dap-go'.setup() -- go debugger dlv

	local dap, dapui = require("dap"), require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
	  dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
	  dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
	  dapui.close()
	end

	vim.fn.sign_define('DapBreakpoint', {text='ඞ', texthl='', linehl='', numhl=''})

	-- cpp specific define the cpp adapter comes from vscode
	require('dap').adapters.cppdbg = {
	  id = 'cppdbg',
	  type = 'executable',
	  command = '/home/vagrant/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
	}

	require('dap').configurations.cpp = {
	  {
	    name = "Launch file",
	    type = "cppdbg",
	    request = "launch",
	    program = function()
	      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	    end,
	    cwd = '${workspaceFolder}',
	    stopOnEntry = true,
	  },
	  {
	    name = 'Attach to gdbserver :1234',
	    type = 'cppdbg',
	    request = 'launch',
	    MIMode = 'gdb',
	    miDebuggerServerAddress = 'localhost:1234',
	    miDebuggerPath = '/usr/bin/gdb',
	    cwd = '${workspaceFolder}',
	    program = function()
	      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	    end,
	  },
	}

