-- Global keymaps. Plugin keymaps live in each lua/plugins/*.lua spec.
-- Leader groups (which-key shows these):  f find · c code · d debug · h harpoon
--                                          n notes · g git · u toggles
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- window navigation (kept from the old tmux-config module)
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- move selected lines
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up", silent = true })

-- keep cursor centered when jumping
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- buffers
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- toggles
map("n", "<leader>uw", function() vim.wo.wrap = not vim.wo.wrap end, { desc = "Toggle wrap" })
map("n", "<leader>ur", function() vim.wo.relativenumber = not vim.wo.relativenumber end,
    { desc = "Toggle relative numbers" })
map("n", "<leader>ud", function()
    local cfg = vim.diagnostic.config() or {}
    vim.diagnostic.config({ virtual_text = not cfg.virtual_text and { spacing = 2, prefix = "●" } or false })
end, { desc = "Toggle diagnostic text" })

-- LSP keymaps are set on attach (lua/plugins/lsp.lua)
