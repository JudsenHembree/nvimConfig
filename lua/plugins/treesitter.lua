-- Treesitter (the "main" branch rewrite for nvim 0.12; parsers compile with tree-sitter-cli)
local parsers = {
    "bash", "c", "cpp", "cuda", "go", "haskell", "javascript", "json", "kotlin", "lua",
    "markdown", "markdown_inline", "python", "query", "regex", "rust", "toml",
    "typescript", "vim", "vimdoc", "yaml", "zig",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.install(parsers)

            -- start highlighting/indent for any buffer whose parser is installed
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(args.match)
                    if lang and pcall(vim.treesitter.start, args.buf, lang) then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },
}
