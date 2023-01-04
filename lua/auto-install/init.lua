local utils = require('utils')
local auto_install = {}

function auto_install.ripgrep()
	local rg = io.popen("rg --version")
	local result = rg:read("*a")
	local notification = {}
	rg:close()
	if result == "" then
		table.insert(notification, "Ripgrep not found, installing...")
		if vim.fn.has("win32") == 1 then
			table.insert(notification, "Windows not currently supported. Do better Jud.")
		elseif vim.fn.has("mac") == 1 then
			table.insert(notification, "Mac not currently supported. Do better Jud.")
		elseif vim.fn.has("unix") == 1 then
			table.insert(notification, "Unix detected, installing...")
			local command = ""
			if vim.fn.executable("apt") == 1 then
				table.insert(notification, "Debian detected, installing...")
				command = "sudo apt-get install ripgrep"
			elseif vim.fn.executable("pacman") == 1 then
				table.insert(notification, "Arch detected, installing...")
				command = "sudo pacman -S ripgrep"
			elseif vim.fn.executable("dnf") == 1 then
				table.insert(notification, "Fedora detected, installing...")
				command = "sudo dnf install ripgrep"
			elseif vim.fn.executable("yum") == 1 then
				table.insert(notification, "Redhat detected, installing...")
				command = "sudo yum install ripgrep"
			end

			--go ahead with command
			if command == "" then
				table.insert(notification, "No package manager detected, please install ripgrep manually.")
			else
				local install = io.popen(command)
				local result = install:read("*a")
				install:close()
				local rg = io.popen("rg --version")
				local result = rg:read("*a")
				rg:close()
				if string.find(result, "not found") then
					table.insert(notification, result)
					table.insert(notification, "Ripgrep not found, please install manually or fix the lua auto-install.")
				else
					table.insert(notification, "Ripgrep installed successfully.")
				end
			end
		end
		utils.notify(notification)
	end
end

function auto_install.auto()
	auto_install.ripgrep()
end

return auto_install
