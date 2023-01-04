-- table to hold the appearance data
local appearance = {}

function appearance.set_scheme(x)
    -- set the colorscheme
	vim.cmd("set number")
	vim.cmd("set termguicolors")
    	vim.cmd('colorscheme ' .. x)
end

--vim.cmd("colorscheme duskfox") -- synthwave :(
return appearance
