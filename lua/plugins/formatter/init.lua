local function configure()
	local ft = require('guard.filetype')

	local autopep8 = {
		cmd = 'autopep8',
		args = {
			"-",
			"--max-line-length",
	        	"150",
	        	"--experimental",
	        	"--ignore",
	        	"E402"
		},
		stdin = true,
	}

	ft('python'):fmt(autopep8)
end

return {
	"nvimdev/guard.nvim",
	-- lazy load by ft
	ft = { "python" },
	-- Builtin configuration, optional
	dependencies = {
		"nvimdev/guard-collection",
	},
	config = configure
}
