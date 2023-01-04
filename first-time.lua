print("Installing/re-installing nvim")

local command = "which nvim"
local handle = io.popen(command)
local result = handle:read("*a")
handle:close()

if result ~= "" then
	command = "rm -rf" .. result
end

command = "sudo mkdir /tmp/nvim"
handle = io.popen(command)
result = handle:read("*a")
handle:close()

if result ~= "" then
	print("Error creating directory")
	return
end

command = "cd /tmp/nvim && sudo curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
handle = io.popen(command)
result = handle:read("*a")
handle:close()

command = "cd /tmp/nvim && sudo chmod 755 nvim.appimage"
handle = io.popen(command)
result = handle:read("*a")
handle:close()

command = "cd /tmp/nvim && sudo mv nvim.appimage /usr/bin/nvim"
handle = io.popen(command)
result = handle:read("*a")
handle:close()


-- Install packer.nvim if not installed
command = "ls ~/.local/share/nvim/site/pack/packer/start/packer.nvim"
handle = io.popen(command)
result = handle:read("*a")
handle:close()
if result == "" then
	command = "git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim"
	handle = io.popen(command)
	result = handle:read("*a")
	handle:close()
end

