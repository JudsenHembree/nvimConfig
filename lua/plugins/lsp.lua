-- LSP: nvim 0.12's built-in vim.lsp.config / vim.lsp.enable, with server
-- definitions from nvim-lspconfig and Mason (:Mason) for installing more.
local servers = {
    "clangd",          -- C / C++ / CUDA   (~/llvm/bin)
    "rust_analyzer",
    "gopls",
    "pyright",
    "ts_ls",           -- was "tsserver"
    "hls",             -- Haskell (ghcup)
    "zls",             -- Zig (~/code/zig/zls)
    "lua_ls",          -- this config
    "kotlin_language_server",
}

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
            { "j-hui/fidget.nvim", opts = { notification = { window = { winblend = 0 } } } },
            "saghen/blink.cmp",
        },
        config = function()
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
                        diagnostics = { globals = { "vim" } },
                        hint = { enable = true },
                    },
                },
            })

            -- only enable servers whose binary exists (system or Mason), so a
            -- missing one never errors on open — install it and it just works
            local enabled = {}
            for _, name in ipairs(servers) do
                local cmd = (vim.lsp.config[name] or {}).cmd
                if type(cmd) == "function" or (type(cmd) == "table" and vim.fn.executable(cmd[1]) == 1) then
                    table.insert(enabled, name)
                end
            end
            vim.lsp.enable(enabled)

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local function map(lhs, rhs, desc)
                        vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
                    end
                    local tb = require("telescope.builtin")
                    -- code group
                    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
                    map("<leader>ci", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
                    end, "Toggle inlay hints")
                    map("<leader>cs", tb.lsp_document_symbols, "Document symbols")
                    map("<leader>cS", tb.lsp_dynamic_workspace_symbols, "Workspace symbols")
                    -- goto (plus nvim's defaults: K hover, grn rename, gra action, grr refs, gri impl)
                    map("gd", tb.lsp_definitions, "Go to definition")
                    map("gr", tb.lsp_references, "References")
                    map("gI", tb.lsp_implementations, "Implementations")
                    map("gy", tb.lsp_type_definitions, "Type definition")
                    -- old binds, kept
                    map("<leader>gd", vim.lsp.buf.definition, "Go to definition")
                    map("<leader>qd", vim.lsp.buf.hover, "Hover docs")
                    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                    map("<leader>in", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
                    end, "Toggle inlay hints")
                end,
            })
        end,
    },
}
