local linter = {}

function linter.setup()
    local ft = require('guard.filetype')
    local diag_fmt = require('guard.lint').diag_fmt
    ft('cpp'):fmt(
    {
        cmd = "clang-format",
        stdin = true
    })
    -- Call setup() LAST!
    require('guard').setup({
        -- the only options for the setup function
        fmt_on_save = true,
        -- Use lsp if no formatter was defined for this filetype
        lsp_as_default_formatter = true,
    })
end

return linter

