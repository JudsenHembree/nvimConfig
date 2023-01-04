local utils = require('utils')
local auto_install = {}

function auto_install.clone_configs()
	local notification = {}
	--prob for configs
	-- tmux
	local command = "ls ~/.config/tmux/tmux.conf"
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()
	if result == "" then
		command = "git clone git@github.com:JudsenHembree/tmux.git ~/.config/tmux"
		handle = io.popen(command)
		result = handle:read("*a")
		handle:close()
		table.insert(notification, result)
		table.insert(notification, "You will likely need to run both :PackerSync and then the tmux install command. It's mapped to alt+space then shift+i.")
		utils.notify(notification)
	else
		table.insert(notification, "tmux config already installed")
	end
end

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
			local command = "sudo mkdir /tmp/ripgrep"
			local handle = io.popen(command)
			local result = handle:read("*a")
			handle:close()
			command = "cd /tmp/ripgrep && sudo curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz && sudo tar -xvf ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz && cd ripgrep-13.0.0-x86_64-unknown-linux-musl && sudo cp rg /usr/bin/"
			handle = io.popen(command)
			result = handle:read("*a")
			handle:close()
			command = "sudo rm -rf /tmp/ripgrep"
			handle = io.popen(command)
			result = handle:read("*a")
			handle:close()
			table.insert(notification, "Ripgrep installed.")
		end
		utils.notify(notification)
	end
end

function auto_install.generic_install(package)
	local notification = {}
	--check if package is installed
	local check = io.popen("which " .. package)
	local result = check:read("*a")
	check:close()
	if result == "" then
		table.insert(notification, package .. " not found, installing...")
		if vim.fn.has("win32") == 1 then
			table.insert(notification, "Windows not currently supported. Do better Jud.")
		elseif vim.fn.has("mac") == 1 then
			table.insert(notification, "Mac not currently supported. Do better Jud.")
		elseif vim.fn.has("unix") == 1 then
			table.insert(notification, "Unix detected, installing...")
			local command = ""
			if vim.fn.executable("apt") == 1 then
				table.insert(notification, "Debian detected, installing...")
				command = "sudo apt-get install " .. package
			elseif vim.fn.executable("pacman") == 1 then
				table.insert(notification, "Arch detected, installing...")
				command = "sudo pacman -S " .. package
			elseif vim.fn.executable("dnf") == 1 then
				table.insert(notification, "Fedora detected, installing...")
				command = "sudo dnf install " .. package
			elseif vim.fn.executable("yum") == 1 then
				table.insert(notification, "Redhat detected, installing...")
				command = "sudo yum install " .. package
			end

			--go ahead with command
			if comand ~= "" then
				local install = io.popen(command)
				local result = install:read("*a")
				install:close()
				local check = io.popen("which " .. package)
				local result = check:read("*a")
				check:close()
				if result == "" then
					table.insert(notification, package .. " not found, please install manually or fix the lua auto-install.")
				else
					table.insert(notification, package .. " installed successfully.")
				end
			else
				table.insert(notification, "No package manager detected, please install " .. package .. " manually.")
			end
		end
		utils.notify(notification)
	end
end

function auto_install.auto()
	auto_install.ripgrep()
	auto_install.generic_install("tmux")
	auto_install.clone_configs()
end

return auto_install
