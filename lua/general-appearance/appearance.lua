-- table to hold the appearance data
local appearance = {}

function appearance.set_scheme(x)
    -- set the colorscheme
	vim.cmd("set number")
	vim.cmd("set termguicolors")
    	vim.cmd('colorscheme ' .. x)
end

function appearance.set_banner(x)
	vim.cmd("set helpfile=banner.txt")
end


--vim.cmd("colorscheme duskfox") -- synthwave :(
return appearance
