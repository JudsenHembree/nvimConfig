local utils = require('utils')

local linter = {}

function linter.setup()
	require('lint').linters_by_ft = {
		python = {'pylint',}
	}

	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		callback = function()
			require('lint').try_lint()
		end,
	})
end

return linter
