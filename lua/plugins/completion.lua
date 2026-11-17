-- Completion (blink.cmp) + formatting (conform.nvim)
return {
    {
        "saghen/blink.cmp",
        version = "1.*",            -- release tag = prebuilt fuzzy-matcher binary
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            keymap = {
                preset = "none",
                -- old nvim-cmp keys, kept
                ["<M-CR>"] = { "show", "fallback" },
                ["<CR>"]   = { "accept", "fallback" },
                ["<C-c>"]  = { "cancel", "fallback" },
                ["<M-j>"]  = { "scroll_documentation_up", "fallback" },
                ["<M-k>"]  = { "scroll_documentation_down", "fallback" },
                -- usual extras
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-n>"]     = { "select_next", "fallback" },
                ["<C-p>"]     = { "select_prev", "fallback" },
                ["<Tab>"]     = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"]   = { "select_prev", "snippet_backward", "fallback" },
                ["<C-y>"]     = { "select_and_accept" },
                ["<C-e>"]     = { "hide", "fallback" },
            },
            completion = {
                list = { selection = { preselect = true, auto_insert = false } },
                menu = {
                    border = "rounded",
                    draw = { columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } } },
                },
                documentation = { auto_show = true, auto_show_delay_ms = 300, window = { border = "rounded" } },
                ghost_text = { enabled = true },
            },
            signature = { enabled = true, window = { border = "rounded" } },
            sources = { default = { "lsp", "path", "snippets", "buffer" } },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
    },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = "ConformInfo",
        keys = {
            { "<leader>cf", function() require("conform").format({ async = true }) end, desc = "Format buffer" },
            {
                "<leader>uf",
                function()
                    vim.g.disable_autoformat = not vim.g.disable_autoformat
                    vim.notify("Format on save " .. (vim.g.disable_autoformat and "off" or "on"))
                end,
                desc = "Toggle format on save",
            },
        },
        opts = {
            formatters_by_ft = {
                c   = { "clang-format" },
                cpp = { "clang-format" },
            },
            -- same behaviour as the old guard.nvim setup: format on save,
            -- using the LSP when no dedicated formatter is configured
            format_on_save = function()
                if vim.g.disable_autoformat then return end
                return { timeout_ms = 1000, lsp_format = "fallback" }
            end,
        },
    },
}
