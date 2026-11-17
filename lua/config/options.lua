local o = vim.opt

-- look
o.number = true
o.cursorline = true            -- highlights the line number only (see colors/dragonfire.lua)
o.signcolumn = "yes"
o.termguicolors = true
o.laststatus = 3               -- one statusline across splits
o.showmode = false             -- lualine shows the mode
o.winborder = "rounded"        -- every floating window gets a rounded border
o.scrolloff = 8
o.sidescrolloff = 8
o.wrap = false
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
o.fillchars = { eob = " " }

-- editing
o.shiftwidth = 4
o.tabstop = 4
o.expandtab = true
o.smartindent = true
o.ignorecase = true
o.smartcase = true
o.undofile = true
o.mouse = "a"
o.splitright = true
o.splitbelow = true
o.updatetime = 250
o.timeoutlen = 400
o.confirm = true

-- system clipboard for every yank/paste (wl-clipboard is installed)
vim.schedule(function() o.clipboard = "unnamedplus" end)

-- diagnostics
vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    virtual_text = { spacing = 2, prefix = "●" },
    float = { border = "rounded", source = "if_many" },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN]  = "󰀪",
            [vim.diagnostic.severity.INFO]  = "󰋽",
            [vim.diagnostic.severity.HINT]  = "󰌶",
        },
    },
})

-- brief highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 }) end,
})

-- prose files (notes) wrap at word boundaries
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
    end,
})
