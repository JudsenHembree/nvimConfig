-- Neovim config — rebuilt Nov 2026 for nvim 0.12 (Arch package) + lazy.nvim.
-- Layout:
--   lua/config/options.lua   editor settings
--   lua/config/keymaps.lua   global keymaps (plugin keys live with their plugin spec)
--   lua/config/lazy.lua      plugin manager bootstrap
--   lua/plugins/*.lua        one file per area (lsp, completion, find, debug, notes, ui, ...)
--   colors/dragonfire.lua    colorscheme matching the Ghostty/Hyprland rice
-- Leader is <Space>; press it and wait to see every binding (which-key).

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.lazy")

vim.cmd.colorscheme("dragonfire")
