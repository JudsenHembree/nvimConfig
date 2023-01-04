-- table include
	local table = require('table')
-- table to return
	local utils = {}



-- shorten the nvim map function
function utils.map(mode, lhs, rhs, opts)
	local options = {noremap = true, silent = true}
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function utils.notify(msg)
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = 50,
		height = 10,
		row = 1,
		col = 10,
		style = "minimal",
	})
	vim.api.nvim_win_set_buf(win, buf)
	if type(msg) ~= "table" then
		msg = {msg}
	end
	if #msg == 0 then
		msg = {"No message"}
	end

	-- for each line in msg
	for i, v in ipairs(msg) do
		for line in string.gmatch(v, "([^\n]*)\n?") do
			vim.api.nvim_buf_set_lines(buf, -1, -1, false, {line})
		end
	end
end


-- leader key. used to toggle into further commands
	utils.map("", "<Space>", "<Nop>", opts)
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "



return utils
